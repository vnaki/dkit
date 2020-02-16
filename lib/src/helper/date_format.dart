///Format date extension
extension DateFormat on DateTime {
  ///Monday to Friday string shorthand
  static const List<String> WeekRange = [
    'Mon',
    'Tue',
    'Wed',
    'Thi',
    'Fri',
    'Sat',
    'Sun'
  ];

  ///Month string shorthand
  static const List<String> MonthRange = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  ///Format date
  ///
  /// eg: Y/m/d h:i:s => 2020/01/20 12:01:08
  ///
  /// Y year, full year, 1999 or 2020
  /// y year, 2-digit year, 99 or 08
  /// M month, no prefix 0, 1 to 12
  /// m month, prefix 0, 01 to 12
  /// D Day of the month, no prefix 0, 1 to 31
  /// d Day of the month, prefix 0, 01 to 31
  /// H 24hours, no prefix 0, 0 to 23
  /// h 24hours, prefix 0, 00 to 23
  /// I minute, no prefix 0, 0 to 59
  /// i minute, prefix 0, 00 to 59
  /// S second, no prefix 0, 0 to 59
  /// s second, prefix 0, 00 to 59
  /// us microsecond
  /// ms millisecond
  /// week Monday to Sunday, ['Mon', 'Tue', 'Wed', 'Thi', 'Fri', 'Sat', 'Sun']
  /// month January to December, ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  String format({String template = 'Y-m-d h:i:s'}) {
    template = template.replaceAll('ms', millisecond.toString());
    template = template.replaceAll('us', microsecond.toString());
    template = template.replaceAll('week', WeekRange[weekday - 1]);
    template = template.replaceAll('month', MonthRange[month - 1]);

    template = template.replaceAll('Y', year.toString());
    template = template.replaceAll('y', year.toString().substring(2));
    template = template.replaceAll('M', month.toString());
    template = template.replaceAll('m', month.toString().padLeft(2, '0'));
    template = template.replaceAll('D', day.toString());
    template = template.replaceAll('d', day.toString().padLeft(2, '0'));
    template = template.replaceAll('H', hour.toString());
    template = template.replaceAll('h', hour.toString().padLeft(2, '0'));
    template = template.replaceAll('I', minute.toString());
    template = template.replaceAll('i', minute.toString().padLeft(2, '0'));
    template = template.replaceAll('S', second.toString());
    template = template.replaceAll('s', second.toString().padLeft(2, '0'));

    return template;
  }
}
