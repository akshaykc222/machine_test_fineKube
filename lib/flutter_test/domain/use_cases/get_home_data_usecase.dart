import 'package:machine_test02/core/usecase.dart';
import 'package:machine_test02/flutter_test/domain/entities/home_enity.dart';
import 'package:machine_test02/flutter_test/domain/repositories/machine_test_reposistory.dart';

class GetHomeDataUseCase extends UseCase<List<HomeEntity>, int> {
  final MachineTestRepository repository;

  GetHomeDataUseCase(this.repository);

  @override
  Future<List<HomeEntity>> call(int params) {
    return repository.getHomeData(params);
  }
}
