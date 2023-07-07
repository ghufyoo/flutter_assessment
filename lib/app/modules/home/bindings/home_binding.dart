import 'package:flutter_starter_template/app/data/repository/gorest/gorest_repository_impl.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(goRestRepositoryImpl: Get.find()),
    );
    Get.lazyPut<GoRestRepositoryImpl>(
      () => GoRestRepositoryImpl(),
    );
  }
}
