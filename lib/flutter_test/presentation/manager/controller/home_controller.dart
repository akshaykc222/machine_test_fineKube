import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test02/core/custom_exception.dart';
import 'package:machine_test02/core/pretty_printer.dart';
import 'package:machine_test02/core/response_classify.dart';
import 'package:machine_test02/flutter_test/domain/entities/home_enity.dart';
import 'package:machine_test02/flutter_test/domain/use_cases/get_home_data_usecase.dart';

class HomeController extends GetxController {
  final GetHomeDataUseCase useCase;

  HomeController(this.useCase) {
    get();
  }
  final scrollController = ScrollController();

  final top = 0.00.obs;
  changeTop(double value) {
    top.value = value;
  }

  final shrinkState = false.obs;
  changeShrinkState() {
    shrinkState.value = !shrinkState.value;
  }

  final homeResponse = ResponseClassify<List<HomeEntity>>.loading().obs;
  final page = 1.obs;
  final homeList = <HomeEntity>[].obs;
  final limitHasReached = false.obs;
  get() async {
    homeResponse.value = ResponseClassify.loading();
    try {
      limitHasReached.value = false;
      prettyPrint("page number $page");
      homeResponse.value =
          ResponseClassify.completed(await useCase.call(page.value));
      homeList.addAll(homeResponse.value.data ?? []);
      prettyPrint("${homeList.length}");
      page.value++;
    } on PageReachedException {
      prettyPrint("maximum page has reached exception");
      limitHasReached.value = true;
    } catch (e) {
      prettyPrint(e.toString());
      homeResponse.value = ResponseClassify.error(e.toString());
    }
  }
}
