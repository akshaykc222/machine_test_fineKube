import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test02/flutter_test/injecter.dart' as dl;
import 'package:machine_test02/flutter_test/presentation/constants.dart';
import 'package:machine_test02/flutter_test/presentation/routes/app_pages.dart';
import 'package:machine_test02/flutter_test/presentation/routes/app_route.dart';
import 'package:machine_test02/flutter_test/presentation/style/app_theme.dart';

Future<void> main() async {
  await dl.init();
  runApp(const FlutterTest());
}

class FlutterTest extends StatelessWidget {
  const FlutterTest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.getThemeData(),
      initialRoute: AppPages.home,
      getPages: appRoutes,
    );
  }
}
