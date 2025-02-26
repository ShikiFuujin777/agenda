import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatUtils {
  static String format(
    BuildContext context, {
    required String newPattern,
    required DateTime dateTime,
  }) =>
      DateFormat(
        newPattern,
        Localizations.localeOf(context).toString(),
      ).format(dateTime);
}

extension DateFormatUtilsExtension on DateTime {
  String format(
    BuildContext context,
    String newPattern,
  ) {
    return DateFormatUtils.format(
      context,
      newPattern: newPattern,
      dateTime: this,
    );
  }
}
