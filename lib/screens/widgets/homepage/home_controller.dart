import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/homepage/home_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_controller.dart';
import 'package:uuid/uuid.dart';

ValueNotifier<List<LengthModel>> countListNotifier = ValueNotifier([]);

LengthModel? lengthModel;

Future<void> getAllCount() async {
  final box1 = await Hive.openBox<LengthModel>('count_db');
  countListNotifier.value.clear();
  countListNotifier.value.addAll(box1.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  countListNotifier.notifyListeners();
  // ignore: avoid_print
  print('All Counts are listed');
}

// Function to update a category in Hive
Future<void> updateCatCount(LengthModel count) async {
  try {
    var box1 = await Hive.openBox<LengthModel>('count_db');
    int index = box1.values.toList().indexWhere((cat) => cat.id == count.id);
    if (index != -1) {
      box1.putAt(index, count);
    } else {
      throw 'Category not found';
    } // Notify listeners after updating
  } catch (error) {
    // ignore: avoid_print
    print('Failed to update category: $error');
    throw 'Failed to update category: $error';
  }
  getAllCount();
}

Future<void> addCatCount(catCount) async {
  // Get the current category count
  

  // Get the existing LengthModel from Hive
  final box = Hive.box<LengthModel>('count_db');
  final lengthModel = box.get(0);

  if (lengthModel != null) {
    // Update the category count in LengthModel
    lengthModel.catlength = catCount.toString();
    box.put(0, lengthModel);
    getAllCount();
  } else {
    // If LengthModel doesn't exist, create a new one and add it to Hive
    final newLengthModel = LengthModel(catlength: catCount.toString());
    await box.add(newLengthModel);
    getAllCount();
  }
}

Future<void> deleteCatCount(int id) async {
  try {
    final box1 = await Hive.openBox<LengthModel>('count_db');
    // Iterate through the box and delete entries with matching ID
    final keys = box1.keys.toList();
    for (var key in keys) {
      final category = box1.get(key);
      if (category != null && category.id == id) {
        await box1.delete(key);
      }
    }
    countListNotifier.value.clear();
  } catch (e) {
    // ignore: avoid_print
    print('Error deleting count: $e');
  }
  await getAllCount();
}

Future<void> loadLengthModel() async {
  final box = await Hive.openBox<LengthModel>('count_db');
  if (box.isNotEmpty) {
    lengthModel = box.getAt(0); // Assuming there's only one item in the box
  }
}
