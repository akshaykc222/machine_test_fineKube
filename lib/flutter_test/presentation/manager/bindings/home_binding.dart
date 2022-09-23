import 'package:get/get.dart';
import 'package:machine_test02/flutter_test/presentation/manager/controller/home_controller.dart';

import '../../../injecter.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(sl()));
  }
}
