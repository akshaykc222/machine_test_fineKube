import 'package:machine_test02/core/connection_info.dart';
import 'package:machine_test02/flutter_test/data/remote/data_sources/remote_data_source.dart';
import 'package:machine_test02/flutter_test/domain/entities/home_enity.dart';
import 'package:machine_test02/flutter_test/domain/repositories/machine_test_reposistory.dart';

import '../local/data_sources/local_data_source.dart';

class MachineTestRepositoryImpl extends MachineTestRepository {
  final RemoteDataSource dataSource;
  final ConnectionInfo connectionInfo;
  final LocalDataSource localDataSource;

  MachineTestRepositoryImpl(
      this.dataSource, this.connectionInfo, this.localDataSource);

  @override
  Future<List<HomeEntity>> getHomeData(int page) async {
    if (await connectionInfo.isConnected) {
      return dataSource.getHomeData(page);
    } else {
      return localDataSource.getHomeData();
    }
  }
}
