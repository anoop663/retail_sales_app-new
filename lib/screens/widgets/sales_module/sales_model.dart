import 'package:hive_flutter/hive_flutter.dart';
part 'sales_model.g.dart';

@HiveType(typeId: 9)
class SalesModel {
  @HiveField(0)
  late String customer;
  @HiveField(1)
  late String product;
  @HiveField(2)
  late String nos;
  @HiveField(3)
  late String total;
  @HiveField(4)
  late String grand;
  @HiveField(5)
  int? id;

  SalesModel({
    required this.customer,
    required this.product,
    required this.nos,
    required this.total,
    required this.grand,
    this.id,
  });
}
