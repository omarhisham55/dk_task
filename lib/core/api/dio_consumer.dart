import 'dart:convert';
import 'package:dakahlia_task/config/dpi/dpi_controller.dart';
import 'package:dakahlia_task/config/error/exceptions.dart';
import 'package:dakahlia_task/core/api/api_consumer.dart';
import 'package:dakahlia_task/core/api/app_interceptor.dart';
import 'package:dakahlia_task/core/api/end_points.dart';
import 'package:dakahlia_task/core/api/status_code.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };

    client.interceptors.add(DpiController.getIt<AppInterceptor>());
    if (kDebugMode) {
      client.interceptors.add(DpiController.getIt<LogInterceptor>());
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? parameters}) async {
    try {
      final response = await client.get(path, queryParameters: parameters);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? body,
    bool formData = false,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: parameters,
        data: formData ? FormData.fromMap(body!) : body,
      );
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(
    String path, {
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response =
          await client.post(path, queryParameters: parameters, data: body);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> jsonResponse) {
    if (jsonResponse.statusCode == 200) {
      final responseJson = jsonDecode(jsonResponse.data.toString());
      return responseJson;
    }
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
        throw const BadRequestException();
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        throw const NoInternetConnectionException();
      case DioExceptionType.unknown:
        throw const UnknownException();
    }
  }
}
