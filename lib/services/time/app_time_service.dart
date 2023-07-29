import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';

class AppTimeService {
  static const String isoTimePattern = "yyyy-MM-dd'T'HH:mm:ss";
  static const String isoDayPattern = "yyyy-MM-dd";
  static const String isoMonthPattern = "yyyy-MM";
  static const String isoYearPattern = "yyyy";
  static const String prettyTimePattern = "dd.MM.yyyy, HH:mm:ss";
  static const String prettyDayPattern = "dd.MM.yyyy";
  static const String prettyMonthPattern = "MMMM yyyy";
  static const String prettyYearPattern = "yyyy";

  String? transformISOTimeString(BuildContext context, String? dateTime,
      {String pattern = prettyTimePattern}) {
    return transformTimeString(context, dateTime,
        inputPattern: isoTimePattern, outputPattern: pattern);
  }

  String? transformISODayString(BuildContext context, String? date,
      {String pattern = prettyDayPattern}) {
    return transformTimeString(context, date,
        inputPattern: isoDayPattern, outputPattern: pattern);
  }

  String? transformTimeString(BuildContext context, String? dateTime,
      {String inputPattern = isoTimePattern,
      String outputPattern = prettyTimePattern}) {
    try {
      DateTime? parsed = parseTimeString(dateTime, pattern: inputPattern);
      if (parsed != null) {
        DateFormat output = DateFormat(
            outputPattern, Localizations.localeOf(context).languageCode);
        return output.format(parsed);
      }
    } on Exception catch (_) {}
    return null;
  }

  String? transformDateTime(BuildContext context, DateTime? dateTime,
      {String pattern = prettyTimePattern}) {
    try {
      if (dateTime != null) {
        DateFormat output =
            DateFormat(pattern, Localizations.localeOf(context).languageCode);
        return output.format(dateTime);
      }
    } on Exception catch (_) {}
    return null;
  }

  DateTime? parseTimeString(String? dateTime,
      {String pattern = isoTimePattern}) {
    try {
      if (dateTime != null) {
        return DateFormat(pattern).parse(dateTime);
      }
    } on Exception catch (_) {}
    return null;
  }

  DateTime? parseDayString(String? date, {String pattern = isoDayPattern}) {
    try {
      if (date != null) {
        return DateFormat(pattern).parse(date);
      }
    } on Exception catch (_) {}
    return null;
  }

  String? transformISOTimeStringToCurrentDuration(
      BuildContext context, String? dateTime) {
    DateTime? start = parseTimeString(dateTime);
    DateTime end = DateTime.now();
    return transformToDurationText(context, start, end);
  }

  String? transformToDurationText(
      BuildContext context, DateTime? start, DateTime? end) {
    if (start == null || end == null || start.isAfter(end)) {
      return null;
    }
    Duration duration = end.difference(start);
    AppLocalizations? localizations = AppLocalizations.of(context);

    if (duration.inSeconds < 60) {
      return "${duration.inSeconds}${localizations!.term_second_short}";
    }
    if (duration.inMinutes < 60) {
      return "${duration.inMinutes}${localizations!.term_minute_short}";
    }
    if (duration.inHours < 24) {
      return "${duration.inHours}${localizations!.term_hour_short}";
    }
    if (duration.inDays < 30) {
      return "${duration.inDays}${localizations!.term_day_short}";
    }
    return "${duration.inDays ~/ 30}${localizations!.term_month_short}";
  }

  String? getIsoPatternForCalendarEnum(AppCalendarEnum? calender) {
    switch (calender) {
      case AppCalendarEnum.DAY:
        return isoDayPattern;
      case AppCalendarEnum.MONTH:
        return isoMonthPattern;
      case AppCalendarEnum.YEAR:
        return isoYearPattern;
      default:
        return null;
    }
  }

  String? getPrettyPatternForCalendarEnum(AppCalendarEnum? calender) {
    switch (calender) {
      case AppCalendarEnum.DAY:
        return prettyDayPattern;
      case AppCalendarEnum.MONTH:
        return prettyMonthPattern;
      case AppCalendarEnum.YEAR:
        return prettyYearPattern;
      default:
        return null;
    }
  }
}
