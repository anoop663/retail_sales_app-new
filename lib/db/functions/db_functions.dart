import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/db/models/data_model.dart';

ValueNotifier<List<RetailModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(RetailModel value) async {
  final retailDB = await Hive.openBox<RetailModel>('retail_db2');
  // ignore: no_leading_underscores_for_local_identifiers
  final _id = await retailDB.add(value);
  value.id = _id;
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final retailDB = await Hive.openBox<RetailModel>('retail_db2');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(retailDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudents(int id) async {
  final retailDB = await Hive.openBox<RetailModel>('retail_db2');
  await retailDB.delete(id);
  getAllStudents();
}
