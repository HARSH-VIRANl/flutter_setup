import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:core/src/constants/env_config.dart';
import 'package:get_it/get_it.dart';

class DioProvider {
  DioProvider._();

  static const String dioInstanceName = 'dioInstance';

  static void setup() {
    _setupDio();
  }

  static void _setupDio() {
    GetIt.instance.registerLazySingleton<Dio>(
      () {
        final Dio dio = Dio(
          BaseOptions(
            followRedirects: false,
            baseUrl: EnvConfig.apiBaseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        );
        if (!kReleaseMode) {
          dio.interceptors.add(
            LogInterceptor(
              requestHeader: true,
              requestBody: true,
              responseHeader: true,
              responseBody: true,
              request: false,
            ),
          );
        }
        return dio;
      },
    );
  }
}
