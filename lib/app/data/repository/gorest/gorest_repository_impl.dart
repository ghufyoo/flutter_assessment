import 'dart:convert';
import 'dart:developer';
import 'package:flutter_starter_template/app/data/models/gorest_user.model.dart';
import 'package:flutter_starter_template/app/data/network/api.enum.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;
import '../../network/dio_interceptor.network.dart';
import 'gorest_repository.dart';

class GoRestRepositoryImpl implements GoRestRepository {
  final apiService = Get.find<NetworkService>();

  @override
  Future getGoRestUserData() async {
    // TODO: implement getCompanyMicrosite
    try {
      dio.Response response = await apiService.get(
        "/users",
        apiBaseUrl: ApiBaseUrl.gorest,
      );
      if (response.statusCode == 200) {
        final goRestUserData =
            goRestUserModelFromJson(jsonEncode(response.data));
        return goRestUserData;
      }
      return null;
    } catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
      throw UnimplementedError(e.toString());
    }
  }
}
