import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/homepage/home_model.dart';

ValueNotifier<List<LengthModel>> countListNotifier = ValueNotifier([]);

LengthModel? lengthModel1;
LengthModel? lengthModel2;
LengthModel? lengthModel3;
LengthModel? lengthModel4;

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
  final lengthModel1 = box.get(0);

  if (lengthModel1 != null) {
    // Update the category count in LengthModel
    lengthModel1.catlength = catCount.toString();
    box.put(0, lengthModel1);
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
    lengthModel1 = box.getAt(0);
    lengthModel2 = box.getAt(1);
    lengthModel3 = box.getAt(2);
    lengthModel4 = box.getAt(3); // Assuming there's only one item in the box
  }
}

Future<void> addProCount(proCount) async {
  // Get the current category count

  // Get the existing LengthModel from Hive
  final box = Hive.box<LengthModel>('count_db');
  final lengthModel2 = box.get(1);

  if (lengthModel2 != null) {
    // Update the category count in LengthModel
    lengthModel2.prolength = proCount.toString();
    box.put(1, lengthModel2);
    getAllCount();
  } else {
    // If LengthModel doesn't exist, create a new one and add it to Hive
    final newLengthModel = LengthModel(prolength: proCount.toString());
    await box.add(newLengthModel);
    getAllCount();
  }
}

Future<void> addCustCount(custCount) async {
  // Get the current category count

  // Get the existing LengthModel from Hive
  final box = Hive.box<LengthModel>('count_db');
  final lengthModel3 = box.get(2);

  if (lengthModel3 != null) {
    // Update the category count in LengthModel
    lengthModel3.custlength = custCount.toString();
    box.put(2, lengthModel3);
    getAllCount();
  } else {
    // If LengthModel doesn't exist, create a new one and add it to Hive
    final newLengthModel = LengthModel(custlength: custCount.toString());
    await box.add(newLengthModel);
    getAllCount();
  }
}

Future<void> addOutCount(outCount) async {
  // Get the current category count

  // Get the existing LengthModel from Hive
  final box = Hive.box<LengthModel>('count_db');
  final lengthModel4 = box.get(3);

  if (lengthModel4 != null) {
    // Update the category count in LengthModel
    lengthModel4.outoflength = outCount.toString();
    box.put(3, lengthModel4);
    getAllCount();
  } else {
    // If LengthModel doesn't exist, create a new one and add it to Hive
    final newLengthModel = LengthModel(outoflength: outCount.toString());
    await box.add(newLengthModel);
    getAllCount();
  }
}
