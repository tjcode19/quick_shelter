import 'package:flutter_money_formatter/flutter_money_formatter.dart';

formatMoney(double amt) {
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: amt);

    MoneyFormatterOutput fo = fmf.output;

    return fo;
  }