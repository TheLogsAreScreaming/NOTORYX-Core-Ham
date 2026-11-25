package com.meshcore.meshcore_open

import android.annotation.SuppressLint
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import es.antonborri.home_widget.HomeWidgetLaunchIntent

/**
 * Quick Settings tile: shows whether the radio is connected and how many
 * messages are unread, and opens the app when tapped. It reads the values
 * the app already writes for the home-screen widget (translated there), so
 * it never shows message text and never sends anything.
 */
class NotoryxTileService : TileService() {
    override fun onStartListening() {
        super.onStartListening()
        refresh()
    }

    override fun onTileAdded() {
        super.onTileAdded()
        refresh()
    }

    private fun refresh() {
        val tile = qsTile ?: return
        val prefs = getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE)
        val connected = prefs.getString("connected", null) == "1"
        tile.state = if (connected) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE
        tile.label = prefs.getString("radio", null) ?: "NOTORYX Core Ham"
        val subtitle = prefs.getString("tile_subtitle", null)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            tile.subtitle = subtitle
        }
        tile.contentDescription = listOfNotNull(tile.label, subtitle).joinToString(", ")
        tile.updateTile()
    }

    @SuppressLint("StartActivityAndCollapseDeprecated")
    override fun onClick() {
        super.onClick()
        val intent = Intent(this, MainActivity::class.java).apply {
            action = HomeWidgetLaunchIntent.HOME_WIDGET_LAUNCH_ACTION
            data = Uri.parse("notoryx://widget/open")
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            val pending = PendingIntent.getActivity(
                this,
                0,
                intent,
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
            )
            startActivityAndCollapse(pending)
        } else {
            @Suppress("DEPRECATION")
            startActivityAndCollapse(intent)
        }
    }

    companion object {
        // Written by the home_widget plugin (HomeWidget.saveWidgetData).
        private const val PREFERENCES = "HomeWidgetPreferences"
    }
}
