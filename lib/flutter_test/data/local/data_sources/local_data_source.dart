import 'package:machine_test02/core/hive_service.dart';
import 'package:machine_test02/flutter_test/data/app_box_names.dart';
import 'package:machine_test02/flutter_test/data/remote/models/home_model.dart';
import 'package:machine_test02/flutter_test/domain/entities/home_enity.dart';

abstract class LocalDataSource {
  Future<List<HomeEntity>> getHomeData();
}

class LocalDataSourceImpl extends LocalDataSource {
  final HiveService hiveService;

  LocalDataSourceImpl(this.hiveService);

  @override
  Future<List<HomeEntity>> getHomeData() async {
    final data = await hiveService.getBox<HomeModel>(boxName: AppBoxNames.home);
    return data.values.toList();
  }
}
