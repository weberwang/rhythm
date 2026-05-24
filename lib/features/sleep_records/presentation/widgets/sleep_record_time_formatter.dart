/// 统一格式化阶段三睡眠记录显示时间，避免页面散落补零逻辑。
String formatSleepRecordTime(int hour, int minute) {
  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
