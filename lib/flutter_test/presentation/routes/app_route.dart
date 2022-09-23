import 'package:get/get.dart';
import 'package:machine_test02/flutter_test/presentation/manager/bindings/home_binding.dart';
import 'package:machine_test02/flutter_test/presentation/pages/home.dart';

import 'app_pages.dart';

var appRoutes = [
  GetPage(
      name: AppPages.home,
      page: () => const HomeScreen(),
      binding: HomeBinding()),
];
