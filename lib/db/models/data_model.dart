import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class RetailModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String phone;
  @HiveField(2)
  final String address;
  @HiveField(3)
  int? id;
  RetailModel(
      {required this.name,
      required this.phone,
      required this.address,
      this.id});
}
