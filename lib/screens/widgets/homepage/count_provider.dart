import 'package:flutter/material.dart';

class CountProvider extends ChangeNotifier {
  int _catCount = 0;
  int _proCount = 0;
  int _outCount = 0;
  int _custCount = 0;

  int get catCount => _catCount;
  int get proCount => _proCount;
  int get outCount => _outCount;
  int get custCount => _custCount;

  void updateCategoryCount(int count) {
    _catCount = count;
    notifyListeners();
  }

  void updateProductCount(int count) {
    _proCount = count;
    notifyListeners();
  }

  void updateOutofStcokCount(int count) {
    _outCount = count;
    notifyListeners();
  }

  void updateCustomerCount(int count) {
    _custCount = count;
    notifyListeners();
  }
}

