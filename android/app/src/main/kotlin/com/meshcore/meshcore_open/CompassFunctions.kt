package com.meshcore.meshcore_open

import android.content.Context
import android.hardware.GeomagneticField
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Build
import android.view.Surface
import android.view.WindowManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

/**
 * The phone's compass for the "point to a node" screen.
 *
 * `notoryx/compass` streams `{heading, accuracy}` maps: heading is degrees
 * clockwise from MAGNETIC north for the top of the screen, accuracy is
 * Android's SENSOR_STATUS_* value (0 unreliable … 3 high).
 * `notoryx/compass_methods` answers `declination(lat, lon, alt)` with the
 * degrees to add to a magnetic heading for true north, from Android's own
 * world magnetic model.
 */
class CompassFunctions(private val activity: FlutterFragmentActivity) :
    SensorEventListener, EventChannel.StreamHandler {

    private val sensorManager by lazy {
        activity.getSystemService(Context.SENSOR_SERVICE) as SensorManager
    }
    private var sink: EventChannel.EventSink? = null
    private var accuracy = SensorManager.SENSOR_STATUS_ACCURACY_MEDIUM
    private var lastSentAt = 0L
    private val rotation = FloatArray(9)
    private val remapped = FloatArray(9)
    private val orientation = FloatArray(3)

    fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        EventChannel(messenger, "notoryx/compass").setStreamHandler(this)
        MethodChannel(messenger, "notoryx/compass_methods")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "declination" -> {
                        val lat = call.argument<Double>("lat")
                        val lon = call.argument<Double>("lon")
                        val alt = call.argument<Double>("alt") ?: 0.0
                        if (lat == null || lon == null) {
                            result.error("bad_args", "lat and lon are required", null)
                        } else {
                            val field = GeomagneticField(
                                lat.toFloat(),
                                lon.toFloat(),
                                alt.toFloat(),
                                System.currentTimeMillis(),
                            )
                            result.success(field.declination.toDouble())
                        }
                    }
                    "hasCompass" -> result.success(rotationSensor() != null)
                    else -> result.notImplemented()
                }
            }
    }

    private fun rotationSensor(): Sensor? =
        sensorManager.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR)
            ?: sensorManager.getDefaultSensor(Sensor.TYPE_GEOMAGNETIC_ROTATION_VECTOR)

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        val sensor = rotationSensor()
        if (sensor == null) {
            events?.error("no_compass", "This device has no compass sensor", null)
            return
        }
        sink = events
        sensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_UI)
    }

    override fun onCancel(arguments: Any?) {
        sensorManager.unregisterListener(this)
        sink = null
    }

    fun dispose() {
        sensorManager.unregisterListener(this)
        sink = null
    }

    override fun onAccuracyChanged(sensor: Sensor?, newAccuracy: Int) {
        accuracy = newAccuracy
    }

    override fun onSensorChanged(event: SensorEvent) {
        val out = sink ?: return
        // About 20 updates a second is plenty for a pointer.
        val now = System.nanoTime()
        if (now - lastSentAt < 50_000_000L) return
        lastSentAt = now

        SensorManager.getRotationMatrixFromVector(rotation, event.values)
        val (axisX, axisY) = when (displayRotation()) {
            Surface.ROTATION_90 -> SensorManager.AXIS_Y to SensorManager.AXIS_MINUS_X
            Surface.ROTATION_180 -> SensorManager.AXIS_MINUS_X to SensorManager.AXIS_MINUS_Y
            Surface.ROTATION_270 -> SensorManager.AXIS_MINUS_Y to SensorManager.AXIS_X
            else -> SensorManager.AXIS_X to SensorManager.AXIS_Y
        }
        SensorManager.remapCoordinateSystem(rotation, axisX, axisY, remapped)
        SensorManager.getOrientation(remapped, orientation)
        val heading = (Math.toDegrees(orientation[0].toDouble()) + 360.0) % 360.0
        val reportedAccuracy =
            if (event.accuracy >= 0) minOf(event.accuracy, accuracy) else accuracy
        out.success(mapOf("heading" to heading, "accuracy" to reportedAccuracy))
    }

    @Suppress("DEPRECATION")
    private fun displayRotation(): Int =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            activity.display?.rotation ?: Surface.ROTATION_0
        } else {
            (activity.getSystemService(Context.WINDOW_SERVICE) as WindowManager)
                .defaultDisplay.rotation
        }
}
