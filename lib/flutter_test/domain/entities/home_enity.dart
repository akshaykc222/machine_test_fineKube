import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final String id;
  final String? name;
  final String? img;
  final String? until;
  final String? amount;
  final String? outOfAmount;

  const HomeEntity(
      {required this.id,
      required this.name,
      required this.img,
      required this.until,
      required this.amount,
      required this.outOfAmount});

  @override
  List<Object?> get props => [id, name];
}
