package com.meshcore.meshcore_open

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterFragmentActivity() {
    private val usbFunctions by lazy { MeshcoreUsbFunctions(this) }
    private val compassFunctions by lazy { CompassFunctions(this) }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        usbFunctions.configureFlutterEngine(flutterEngine)
        compassFunctions.configureFlutterEngine(flutterEngine)
    }

    override fun onDestroy() {
        usbFunctions.dispose()
        compassFunctions.dispose()
        super.onDestroy()
    }
}
