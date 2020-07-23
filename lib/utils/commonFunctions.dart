import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';

formatMoney(double amt) {
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amt);
    MoneyFormatterOutput fo = fmf.output;
    return fo;
  }

  formatDate(String selDate, {pattern:'dd MMM, yyyy'}){
    var date1 = DateTime.parse(selDate);
        // DateTime now = DateTime.now();
        String formattedDate = DateFormat(pattern).format(date1);
        return formattedDate;
  }