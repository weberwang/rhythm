package com.example.rhythm

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

/**
 * Android 桌面小组件 Provider。
 *
 * 这里集中把 Dart 侧快照字段映射到原生 RemoteViews，保证
 * `home_widget` 刷新时始终能找到有效的 Provider，并且点击小组件
 * 可以按快照里的入口 URI 冷启动回应用。
 */
class RhythmHomeWidgetProvider : HomeWidgetProvider() {
    /**
     * 把 Dart 侧写入的共享快照渲染成 RemoteViews。
     *
     * Android 桌面小组件没有直接读取 Flutter Widget 的能力，因此这里需要
     * 在原生层做一次稳定映射，保证系统刷新与首次添加都能拿到同一份展示结果。
     */
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        appWidgetIds.forEach { widgetId ->
            val views =
                RemoteViews(context.packageName, R.layout.rhythm_home_widget).apply {
                    val entryUri = widgetData.getString(KEY_ENTRY_URI, null)?.let(android.net.Uri::parse)
                    val launchIntent =
                        HomeWidgetLaunchIntent.getActivity(
                            context,
                            MainActivity::class.java,
                            entryUri,
                        )
                    setOnClickPendingIntent(R.id.widget_root, launchIntent)

                    val snapshotState = widgetData.getString(KEY_SNAPSHOT_STATE, STATE_GOAL_MISSING)
                    val bedtimeLabel = widgetData.getString(KEY_TARGET_BEDTIME_LABEL, "--:--") ?: "--:--"
                    val lastNightLabel = widgetData.getString(KEY_LAST_NIGHT_STATUS_LABEL, null)
                    val minutesToTarget = readMinutesToTarget(widgetData)

                    setTextViewText(R.id.widget_target_bedtime_value, bedtimeLabel)
                    setTextViewText(R.id.widget_status_title, resolveStatusTitle(context, snapshotState))
                    setTextViewText(
                        R.id.widget_status_body,
                        resolveStatusBody(context, snapshotState, lastNightLabel),
                    )

                    val deltaText = resolveDeltaLabel(context, minutesToTarget)
                    if (deltaText == null) {
                        setViewVisibility(R.id.widget_target_delta, View.GONE)
                    } else {
                        setViewVisibility(R.id.widget_target_delta, View.VISIBLE)
                        setTextViewText(R.id.widget_target_delta, deltaText)
                    }
                }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

    /**
     * 兼容 `home_widget` 保存 `int` 时可能写成 `Int`、`Long` 或 `String` 的情况，
     * 避免小组件因为类型差异直接丢失倒计时文案。
     */
    private fun readMinutesToTarget(widgetData: SharedPreferences): Int? {
        val rawValue = widgetData.all[KEY_MINUTES_TO_TARGET] ?: return null
        return when (rawValue) {
            is Int -> rawValue
            is Long -> rawValue.toInt()
            is String -> rawValue.toIntOrNull()
            else -> null
        }
    }

    /**
     * 标题只承载状态标签，避免把较长的业务摘要塞进单行标题导致桌面折叠严重。
     */
    private fun resolveStatusTitle(context: Context, snapshotState: String?): String {
        return when (snapshotState) {
            STATE_READY -> context.getString(R.string.rhythm_widget_status_ready)
            STATE_NO_DATA -> context.getString(R.string.rhythm_widget_status_no_data)
            STATE_PERMISSION_REQUIRED -> context.getString(R.string.rhythm_widget_status_permission_required)
            else -> context.getString(R.string.rhythm_widget_status_goal_missing)
        }
    }

    /**
     * 已有昨晚摘要时优先展示业务结果；否则回退到状态说明，避免桌面上出现空白正文。
     */
    private fun resolveStatusBody(
        context: Context,
        snapshotState: String?,
        lastNightLabel: String?,
    ): String {
        if (!lastNightLabel.isNullOrBlank()) {
            return lastNightLabel
        }
        return when (snapshotState) {
            STATE_READY,
            STATE_NO_DATA -> context.getString(R.string.rhythm_widget_body_no_data)
            STATE_PERMISSION_REQUIRED -> context.getString(R.string.rhythm_widget_body_permission_required)
            else -> context.getString(R.string.rhythm_widget_body_goal_missing)
        }
    }

    /**
     * 倒计时字段缺失时直接隐藏，避免把占位符误显示成真实提醒信息。
     */
    private fun resolveDeltaLabel(context: Context, minutesToTarget: Int?): String? {
        if (minutesToTarget == null) {
            return null
        }
        return if (minutesToTarget < 0) {
            context.getString(R.string.rhythm_widget_delta_late, -minutesToTarget)
        } else {
            context.getString(R.string.rhythm_widget_delta_ahead, minutesToTarget)
        }
    }

    companion object {
        private const val KEY_SNAPSHOT_STATE = "snapshot_state"
        private const val KEY_TARGET_BEDTIME_LABEL = "target_bedtime_label"
        private const val KEY_MINUTES_TO_TARGET = "minutes_to_target"
        private const val KEY_LAST_NIGHT_STATUS_LABEL = "last_night_status_label"
        private const val KEY_ENTRY_URI = "entry_uri"

        private const val STATE_READY = "ready"
        private const val STATE_GOAL_MISSING = "goalMissing"
        private const val STATE_NO_DATA = "noData"
        private const val STATE_PERMISSION_REQUIRED = "permissionRequired"
    }
}
