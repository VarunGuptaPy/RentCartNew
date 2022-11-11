import 'package:flutter/material.dart';

class AddressChanger extends ChangeNotifier {
  int _counter = 0;
  int get count => _counter;
  displayAddress(dynamic number) async {
    _counter = number;
    Future.delayed(Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
