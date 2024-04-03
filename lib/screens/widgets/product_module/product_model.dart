import 'package:hive_flutter/hive_flutter.dart';

part 'product_model.g.dart';

@HiveType(typeId: 3)
class CategoryModel {
  @HiveField(0)
  late String name;

  @HiveField(1)
  int? id; // Change id to non-nullable int

  CategoryModel({
    required this.name,
    this.id, // Update constructor to require id
  });
}

@HiveType(typeId: 5)
class ProductModel {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String code;
   @HiveField(2)
  late String price;
   @HiveField(3)
  late String stock;
     @HiveField(4)
  late String date;
  @HiveField(5)
  late String? image;
   @HiveField(6)
  int? id;

  ProductModel({
    required this.name,
    required this.code,
    required this.stock,
    required this.price,
    required this.date,
    this.image,
    this.id,
  });
}
