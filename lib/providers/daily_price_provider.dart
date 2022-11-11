import 'package:flutter/material.dart';

class DailyPriceProvider extends ChangeNotifier {
  int dailyPrice = 0;
  int get count => dailyPrice;
  changeDailyPrice(dynamic number) async {
    dailyPrice = number;
    Future.delayed(Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
