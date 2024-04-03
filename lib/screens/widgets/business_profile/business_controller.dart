// business_controller.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_model.dart';
import 'package:uuid/uuid.dart';

ValueNotifier<List<RetailModel2>> businessListNotifier = ValueNotifier([]);

Future<void> getAllBusines() async {
  final retailDB = await Hive.openBox<RetailModel2>('retail_db');
  businessListNotifier.value.clear();
  businessListNotifier.value.addAll(retailDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  businessListNotifier.notifyListeners();
  // ignore: avoid_print
  print('All Categories are listed');
}

// Function to update a category in Hive
Future<void> updateBusiness(RetailModel2 business) async {
  final retailDB1 = await Hive.openBox<RetailModel2>('retail_db');
  if (retailDB1.isNotEmpty && retailDB1.containsKey(business.id)) {
    await retailDB1.put(business.id, business);
    final keys = retailDB1.keys;
    final id = keys.isNotEmpty ? keys.first : null;
    if (id != null) {
      await retailDB1.put(id, business);
      getAllBusines();
    }
  }
}

Future<void> addBusiness(RetailModel2 business) async {
  final retailDB = await Hive.openBox<RetailModel2>('retail_db');
  const uuid = Uuid();
  final uuidString = uuid.v4(); // Generate UUID as a string
  final id = uuidString.hashCode.abs(); // Convert UUID string to integer
  business.id = id;
  await retailDB.add(business);
  print(business.id.toString());
  print(business.name);
  print(business.phone);
  print(business.address);
  getAllBusines();
}
