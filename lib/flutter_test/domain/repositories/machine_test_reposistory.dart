import 'package:machine_test02/flutter_test/domain/entities/home_enity.dart';

abstract class MachineTestRepository {
  Future<List<HomeEntity>> getHomeData(int page);
}
