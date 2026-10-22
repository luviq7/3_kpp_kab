/// Форматування дат українською без сторонніх пакетів.
abstract final class AppDateFormat {
  static const _monthsGenitive = [
    'січня', 'лютого', 'березня', 'квітня', 'травня', 'червня',
    'липня', 'серпня', 'вересня', 'жовтня', 'листопада', 'грудня',
  ];

  static const _monthsShort = [
    'січ.', 'лют.', 'бер.', 'квіт.', 'трав.', 'черв.',
    'лип.', 'серп.', 'вер.', 'жовт.', 'лист.', 'груд.',
  ];

  /// 18 травня 2026
  static String long(DateTime date) =>
      '${date.day} ${_monthsGenitive[date.month - 1]} ${date.year}';

  /// 22 квітня
  static String dayMonth(DateTime date) =>
      '${date.day} ${_monthsGenitive[date.month - 1]}';

  /// 18 вер. 2026
  static String short(DateTime date) =>
      '${date.day} ${_monthsShort[date.month - 1]} ${date.year}';
}
