import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 9)
class SalesModel {
  @HiveField(0)
  late String customer;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String phone;
  @HiveField(3)
  late String address;
  @HiveField(4)
  late String product;
  @HiveField(5)
  late String nos;
  @HiveField(6)
  late String total;
  @HiveField(7)
  late String grand;
  @HiveField(8)
  int? id;

  SalesModel({
    required this.customer,
    required this.name,
    required this.phone,
    required this.address,
    required this.product,
    required this.nos,
    required this.total,
    required this.grand,
    this.id,
  });
}
