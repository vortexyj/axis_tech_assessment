import 'package:core/utils/constants/app_constants.dart';
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
