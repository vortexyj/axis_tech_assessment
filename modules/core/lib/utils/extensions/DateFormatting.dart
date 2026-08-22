import 'dart:ui';

import 'package:core/utils/constants/app_constants.dart';
import 'package:core/utils/values/app_values.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as date_formatter;

extension DateFormatting on String {
  String convertDate(
    bool isRTL, {
    String? format = "${AppConst.dateFormatType3}, ${AppConst.timeFormatType3}",
  }) {
    initializeDateFormatting();
    var inputFormat = date_formatter.DateFormat(
      '${AppConst.dateFormatType2} ${AppConst.timeFormatType1}',
    );
    var inputDate = inputFormat.parse(this);
    var outputFormat = date_formatter.DateFormat(
      format,
      isRTL ? AppConst.arEgLangCode : AppConst.enUSLangCode,
    );
    var outputDateArabic = outputFormat.format(inputDate);
    var outputDateEnglish = outputFormat.format(inputDate);
    return isRTL ? outputDateArabic : outputDateEnglish;
  }

  double toDouble() {
    return double.parse(this);
  }
}

extension HexColor on String {
  Color toColor({double? opacity = 1.0}) {
    String hex = startsWith('#') ? substring(1) : this;

    if (hex.length > 6) {
      hex = hex.substring(0, 6);
    }
    int value = int.parse(hex, radix: 16);
    if (hex.length == 6) {
      value =
          ((opacity! * AppValues.color255).toInt() << AppValues.colorShift) |
          value;
    }
    return Color(value);
  }
}
