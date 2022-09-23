import 'package:machine_test02/core/api_provider.dart';
import 'package:machine_test02/core/custom_exception.dart';
import 'package:machine_test02/core/pretty_printer.dart';
import 'package:machine_test02/flutter_test/data/app_box_names.dart';
import 'package:machine_test02/flutter_test/data/app_remote_routes.dart';
import 'package:machine_test02/flutter_test/data/remote/models/home_model.dart';
import 'package:machine_test02/flutter_test/domain/entities/home_enity.dart';

import '../../../../core/hive_service.dart';

abstract class RemoteDataSource {
  Future<List<HomeEntity>> getHomeData(int page);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final ApiProvider apiProvider;
  final HiveService hiveService;
  RemoteDataSourceImpl(this.apiProvider, this.hiveService);

  @override
  Future<List<HomeEntity>> getHomeData(int page) async {
    final data = await apiProvider.get("${AppRemoteRoutes.home}pageNo=$page");
    int totPage = data['total_pages'];
    int currentPage = data['page'];
    prettyPrint("total page $totPage current page $currentPage");
    if (totPage == currentPage) {
      throw PageReachedException();
    }
    final listData =
        List<HomeModel>.from(data['data'].map((x) => HomeModel.fromJson(x)));
    prettyPrint(listData.length.toString());
    for (var element in listData) {
      prettyPrint(element.name);
    }
    hiveService.addBoxes<HomeModel>(listData, AppBoxNames.home);
    return listData;
  }
}
