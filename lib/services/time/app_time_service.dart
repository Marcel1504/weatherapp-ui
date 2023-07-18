import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class AppTimeService {
  String? transformISODateTimeString(BuildContext context, String? dateTime,
      {String pattern = "dd.MM.yyyy, HH:mm:ss"}) {
    try {
      DateTime? parsed = parseDateTimeString(dateTime);
      if (parsed != null) {
        DateFormat output =
            DateFormat(pattern, Localizations.localeOf(context).languageCode);
        return output.format(parsed);
      }
    } on Exception catch (_) {}
    return null;
  }

  DateTime? parseDateTimeString(String? dateTime,
      {String pattern = "yyyy-MM-dd'T'HH:mm:ss"}) {
    try {
      if (dateTime != null) {
        return DateFormat(pattern).parse(dateTime);
      }
    } on Exception catch (_) {}
    return null;
  }

  String? transformISODateString(BuildContext context, String? date,
      {String pattern = "dd.MM.yyyy"}) {
    try {
      DateTime? parsed = parseDateTimeString(date);
      if (parsed != null) {
        DateFormat output =
            DateFormat(pattern, Localizations.localeOf(context).languageCode);
        return output.format(parsed);
      }
    } on Exception catch (_) {}
    return null;
  }

  DateTime? parseDateString(String? date, {String pattern = "yyyy-MM-dd"}) {
    try {
      if (date != null) {
        return DateFormat(pattern).parse(date);
      }
    } on Exception catch (_) {}
    return null;
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

  String? transformISODateTimeStringToCurrentDuration(
      BuildContext context, String? dateTime) {
    DateTime? start = parseDateTimeString(dateTime);
    DateTime end = DateTime.now();
    return transformToDurationText(context, start, end);
  }
}
