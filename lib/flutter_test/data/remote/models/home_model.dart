import 'package:hive/hive.dart';
import 'package:machine_test02/flutter_test/domain/entities/home_enity.dart';

part 'home_model.g.dart';

@HiveType(typeId: 1)
class HomeModel extends HomeEntity {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String img;
  @HiveField(3)
  String until;
  @HiveField(4)
  String amount;
  @HiveField(5)
  String outOfAmount;

  HomeModel(
      {required this.id,
      required this.name,
      required this.img,
      required this.until,
      required this.amount,
      required this.outOfAmount})
      : super(
            id: id,
            name: name,
            img: img,
            until: until,
            amount: amount,
            outOfAmount: outOfAmount);
  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
      id: json['id'],
      name: json['Name'],
      img: json['Img'],
      until: json['Until'],
      amount: json['Amount'],
      outOfAmount: json['OutOfAmount']);
}
