import 'package:hive_flutter/hive_flutter.dart';
part 'home_model.g.dart';

@HiveType(typeId: 12)
class LengthModel {
  @HiveField(0)
  late String? catlength;
  @HiveField(1)
   late String? prolength;
  @HiveField(2)
  late String? custlength;
  @HiveField(3)
  late String? outoflength;
  @HiveField(4)
  late String? salevalue;
  @HiveField(5)
  int? id;

  LengthModel({
     this.catlength,
     this.prolength,
     this.custlength,
     this.outoflength,
     this.salevalue,
    this.id,
  });
}

