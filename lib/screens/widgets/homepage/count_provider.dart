import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
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

    final box1 = await Hive.openBox<ProductModel>('product_db2');
    final box2 = await Hive.openBox<CustomerModel>('customer_db');
    final box3 = await Hive.openBox<CategoryModel>('product_db');
    _catCount = box3.length;
    _proCount = box1.length;
    _outCount1 = prefs.getInt('outCount') ?? 0;
    _custCount = box2.length;
    notifyListeners();
  }

  void updateCategoryCount2(int count1) async {
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
