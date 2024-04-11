import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountProvider extends ChangeNotifier {
  int _catCount = 0;
  int _proCount = 0;
  int _outCount1 = 0;
  int _custCount = 0;

  int get catCount => _catCount;
  int get proCount => _proCount;
  int get outCount => _outCount1;
  int get custCount => _custCount;

  // Method to load counts from shared preferences
  Future<void> loadCounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _catCount = prefs.getInt('catCount') ?? 0;
    _proCount = prefs.getInt('proCount') ?? 0;
    _outCount1 = prefs.getInt('outCount') ?? 0;
    _custCount = prefs.getInt('custCount') ?? 0;
    notifyListeners();
  }

  void updateCategoryCount(int count1) async {
    _catCount = count1;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('catCount', count1);
  }

  void updateProductCount(int count2) async {
    _proCount = count2;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('proCount', count2);
  }

  void updateOutofStcokCount(int count3) async {
    _outCount1 = count3;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('outCount', count3);
  }

  void updateCustomerCount(int count4) async {
    _custCount = count4;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('custCount', count4);
  }
}
