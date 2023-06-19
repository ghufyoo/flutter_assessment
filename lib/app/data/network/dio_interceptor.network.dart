import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_starter_template/app/data/network/api.enum.dart';
import 'package:get/get.dart';
import '../../../core/dialog/error_response.dialog.dart';
import '../../../core/dialog/no_internet.dialog.dart';
import 'network_service.network.dart';

class NetworkService extends GetxService {
  final _goRestUrl = "https://gorest.co.in/public/v2/";
  final _goGraphQLUrl = "https://gorest.co.in/public/v2/graphql";

  late dio.Dio _dio;

  NetworkService() {
    dio.BaseOptions options = dio.BaseOptions(
      receiveTimeout: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
      headers: {},
      // validateStatus: (status) {
      //   log('Status: $status');
      //   return status! <= 500;
      // });
    );
    _dio = dio.Dio(options);
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future get(String endpoint, {required ApiBaseUrl apiBaseUrl,Map<String, dynamic> data = const {}}) async {
    final baseUrl = _apiBaseUrlSelector(apiBaseUrl);
    if(baseUrl == "NULL")return;
    if (Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }
    dio.Response response;
    try {
      response = await _dio.get(
        baseUrl + endpoint,
        queryParameters: data,
        // options: dio.Options(headers: {
        //   'Authorization': "Bearer token",
        // })
      );
      return response;
    } on dio.DioException catch (error) {
      if (Get.isDialogOpen!) {
        Get.close(1);
      }
      String er = _handleError(error);
      log(er);
      await _dialogResponse(error);
    }
  }

  Future post(String endpoint,
      {required ApiBaseUrl apiBaseUrl, Function(int, int)? onsendProgress,var data,}) async {
        final baseUrl = _apiBaseUrlSelector(apiBaseUrl);
    dio.Response response;
    try {
      response = await _dio.post(baseUrl + endpoint,
          options: dio.Options(headers: {
            "Content-Type": "application/json",
            //'Authorization': "Bearer $bearer",
          }),
          data: data,
          onSendProgress: onsendProgress);
      return response;
    } on dio.DioException catch (error) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      String er = _handleError(error);
      log(er);
      await _dialogResponse(error);
    }
  }

  Future put(String endpoint,{required ApiBaseUrl apiBaseUrl,var data}) async {
       final baseUrl = _apiBaseUrlSelector(apiBaseUrl);
    dio.Response response;
    try {
      response = await _dio.put(baseUrl + endpoint,
          // options: dio.Options(headers: {
          //   'Authorization':
          //       "Bearer ${Get.find<LocalDbService>().getUser().token}"
          // }),
          data: data);
      return response;
    } on dio.DioException catch (error) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      String er = _handleError(error);
      log(er);
      await _dialogResponse(error);
    }
  }
  Future patch(String endpoint,{required ApiBaseUrl apiBaseUrl,var data}) async {
     final baseUrl = _apiBaseUrlSelector(apiBaseUrl);
    dio.Response response;
    //ConstantWidget().loading;
    try {
      response = await _dio.put(baseUrl + endpoint,
          // options: dio.Options(headers: {
          //   'Authorization':
          //       "Bearer ${Get.find<LocalDbService>().getUser().token}"
          // }),
          data: data);
      return response;
    } on dio.DioException catch (error) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      String er = _handleError(error);
      log(er);
      await _dialogResponse(error);
    }
  }

  Future delete(String endpoint,{required ApiBaseUrl apiBaseUrl,var data}) async {
 final baseUrl = _apiBaseUrlSelector(apiBaseUrl);
    dio.Response response;
    try {
      response = await _dio.delete(baseUrl + endpoint,
          options: dio.Options(headers: {
            'Authorization': "Bearer ",
          }),
          data: data);
      return response;
    } on dio.DioException catch (error) {
      String er = _handleError(error);
      log(er);
      await _dialogResponse(error);
    }
  }

  String _apiBaseUrlSelector(ApiBaseUrl apiBaseUrl){
    switch (apiBaseUrl) {
      case ApiBaseUrl.gorest:
        return _goRestUrl;
      case ApiBaseUrl.gograph:
        return _goGraphQLUrl;
      case ApiBaseUrl.lalamove:
        return "NULL";
      case ApiBaseUrl.googleMap:
        return "NULL";
      default:
        return "NULL";
    }
  }


  String _handleError(dio.DioException error) {
    String errorDescription = "";
    // ignore: unnecessary_type_check
    if (error is dio.DioException) {
      switch (error.type) {
        case dio.DioExceptionType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case dio.DioExceptionType.connectionTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case dio.DioExceptionType.badCertificate:
          errorDescription = "Bad certificate with API server";
          break;
        case dio.DioExceptionType.connectionError:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case dio.DioExceptionType.unknown:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case dio.DioExceptionType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case dio.DioExceptionType.badResponse:
          errorDescription =
              "Received invalid status code: ${error.response!.statusCode}";
          break;
        case dio.DioExceptionType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }


  _dialogResponse(dio.DioException error) {
    // log(error.response.toString());
    if (error.response?.statusCode == 400) {
      return Get.dialog(
          ErrorResponseDialog(errorText: error.response.toString()),
          barrierColor: Colors.black.withOpacity(0.5));
    } else if (error.response?.statusCode == 500) {
      return Get.dialog(
          ErrorResponseDialog(errorText: error.response.toString()),
          barrierColor: Colors.black.withOpacity(0.5));
    } else if (error.response?.statusCode == null) {
      return Get.dialog(const NoInternetConnectionDialog(),
          barrierColor: Colors.black.withOpacity(0.5));
    } else {}
  }
}
