import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:machine_test02/core/connection_info.dart';
import 'package:machine_test02/flutter_test/data/local/data_sources/local_data_source.dart';
import 'package:machine_test02/flutter_test/data/remote/data_sources/remote_data_source.dart';
import 'package:machine_test02/flutter_test/data/remote/models/home_model.dart';
import 'package:machine_test02/flutter_test/data/repositories/machine_test_repository_impl.dart';
import 'package:machine_test02/flutter_test/domain/repositories/machine_test_reposistory.dart';
import 'package:machine_test02/flutter_test/domain/use_cases/get_home_data_usecase.dart';

import '../core/api_provider.dart';
import '../core/hive_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //data source
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(sl(), sl()));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(sl()));

  //repository
  sl.registerLazySingleton<MachineTestRepository>(
      () => MachineTestRepositoryImpl(sl(), sl(), sl()));
  //use case
  sl.registerLazySingleton<GetHomeDataUseCase>(() => GetHomeDataUseCase(sl()));

  //core
  sl.registerLazySingleton<HiveService>(() => HiveService());
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<ConnectionInfo>(() => ConnectionInfoImpl(sl()));
  await Hive.initFlutter();
  Hive.registerAdapter(HomeModelAdapter());
}
