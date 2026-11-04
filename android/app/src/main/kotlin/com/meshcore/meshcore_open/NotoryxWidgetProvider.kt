package com.meshcore.meshcore_open

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import com.bastionmesh.bastion.R
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

/**
 * Home-screen widget: radio name and status, battery, unread messages, and
 * Check in / SOS buttons. The app writes the values (already translated);
 * the buttons only open the app, where check-in is reviewed and SOS still
 * needs its hold, so a stray tap never sends anything.
 */
class NotoryxWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        for (id in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.notoryx_widget).apply {
                setTextViewText(R.id.widget_radio, widgetData.getString("radio", null) ?: "NOTORYX Core Ham")
                setTextViewText(R.id.widget_status, widgetData.getString("status", null) ?: "")
                setTextViewText(R.id.widget_battery_label, widgetData.getString("lbl_battery", null) ?: "Battery")
                setTextViewText(R.id.widget_battery, widgetData.getString("battery", null) ?: "—")
                setTextViewText(R.id.widget_unread_label, widgetData.getString("lbl_unread", null) ?: "Unread")
                setTextViewText(R.id.widget_unread, widgetData.getString("unread", null) ?: "0")
                setTextViewText(R.id.widget_checkin, widgetData.getString("lbl_checkin", null) ?: "Check in")
                setTextViewText(R.id.widget_sos, widgetData.getString("lbl_sos", null) ?: "SOS")
                setOnClickPendingIntent(
                    R.id.widget_root,
                    HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java, Uri.parse("notoryx://widget/open")),
                )
                setOnClickPendingIntent(
                    R.id.widget_checkin,
                    HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java, Uri.parse("notoryx://widget/checkin")),
                )
                setOnClickPendingIntent(
                    R.id.widget_sos,
                    HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java, Uri.parse("notoryx://widget/sos")),
                )
            }
            appWidgetManager.updateAppWidget(id, views)
        }
    }
}
