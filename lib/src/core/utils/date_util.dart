import 'package:intl/intl.dart';

class DateUtilities {
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  String getDurationString(Duration duration) {
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String getFormattedDateString(DateTime date, {String? formatter}) {
    if (formatter == null) {
      formatter = kMainSourceFormat;
    }

    return DateFormat(formatter).format(date);
  }

  String valuesToEnglishDays(List<bool> values, bool searchedValue) {
    final days = <String>[];
    for (int i = 0; i < values.length; i++) {
      final v = values[i];
      // Use v == true, as the value could be null, as well (disabled days).
      if (v == searchedValue) days.add(intDayToEnglish(i));
    }
    if (days.isEmpty) return 'NONE';
    return days.join(', ');
  }

  String intDayToEnglish(int day) {
    if (day % 7 == DateTime.monday % 7) return 'Monday';
    if (day % 7 == DateTime.tuesday % 7) return 'Tueday';
    if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
    if (day % 7 == DateTime.thursday % 7) return 'Thursday';
    if (day % 7 == DateTime.friday % 7) return 'Friday';
    if (day % 7 == DateTime.saturday % 7) return 'Saturday';
    if (day % 7 == DateTime.sunday % 7) return 'Sunday';
    throw '🐞 This should never have happened: $day';
  }

  DateTime getDateFromString(String dateString, {String? formatter}) {
    if (formatter == null) {
      formatter = kMainSourceFormat;
    }

    return DateFormat(formatter).parse(dateString);
  }

  String convertDateToFormatterString(String dateString, {String? formatter}) {
    return getFormattedDateString(
      getDateFromString(dateString, formatter: formatter),
      formatter: formatter,
    );
  }

  String convertServerDateToFormatterString(String dateString,
      {String? formatter}) {
    return getFormattedDateString(
      getDateFromString(dateString, formatter: kSourceFormat),
      formatter: formatter,
    );
  }

  String dayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 0, 0, 0);
  }

  String getFormattedDay(DateTime date) {
    var dt = getStartOfDay(date);
    var currentDate = getStartOfDay(DateTime.now());

    final diffInDays = currentDate.difference(dt).inDays;
    if (diffInDays == 0) {
      // current day
      return "Today";
    } else if (diffInDays == 1) {
      // 1 day
      return "Yesterday";
    } else if (diffInDays >= 2 && diffInDays <= 6) {
      // same week
      return getFormattedDateString(date, formatter: eeee);
    } else {
      // more than week
      String strDate = getFormattedDateString(date, formatter: eee_dd_mmm_yyyy);
      return strDate + " at";
    }
  }

  static const String kMainSourceFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS";

  static const kSourceFormat = "yyyy-MM-dd'T'HH:mm:ss";
  static const String dd_mm_yyyy_hh_mm = "dd-MM-yyyy HH:mm";
  static const String dd_mm_yyyy_hh_mm_a = "dd-MM-yyyy hh:mm a";
  static const String dd_mm_yyyy_hh_mm_ss_a = "dd-MM-yyyy hh:mm:ss a";
  static const String dd_mm_yyyy = "dd MMM yyyy";
  static const String dd_mmm = "dd MMM";
  static const String mm_yyyy = "MM/yyyy";
  static const String dd = "d";
  static const String mmm = "MMM";
  static const String yyyy = "yyyy";
  static const String file_name_date = "dd MMM yyyy";
  static const String dd_mm_yyyy_ = "dd-MM-yyyy";
  static const String yyyy_mm_dd = "yyyy-MM-dd";

  static const String ddmmyyyy_ = "dd/MM/yyyy";
  static const String hh_mm_ss = "HH:mm:ss";
  static const String hh_mm_a = "hh:mm a";
  static const String h_mm_a = "h:mm a";
  static const String eeee = "EEEE";
  static const String eee_dd_mmm_yyyy = "EEE, DD MMM yyyy";

  static const String dd_mmm_yy_h_mm_a = "dd MMM''yy 'at' h:mma";
}
