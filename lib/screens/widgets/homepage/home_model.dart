import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';

class CountsModel extends ChangeNotifier {
  int categoryCount = 0;
  int productCount = 0;
  int customerCount = 0;
  int outOfStockCount = 0;

  // Update counts based on the provided list of categories
  void updateCounts(List<CategoryModel> categories) {
    // Update category count
    categoryCount = categories.length;

    // Notify listeners
    notifyListeners();
  }
}