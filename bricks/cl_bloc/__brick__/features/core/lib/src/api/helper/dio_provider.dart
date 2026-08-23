import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:core/core_exports.dart';

class DioProvider {
  DioProvider._();

  static const String dioInstanceName = 'dioInstance';

  static void setup() {
    _setupDio();
  }

  static void _setupDio() {
    GetIt.instance.registerLazySingleton<Dio>(
      () {
        final appPreference = GetIt.instance.get<AppPreference>();

        final Dio dio = Dio(
          BaseOptions(
            followRedirects: false,
            baseUrl: EnvConfig.apiBaseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        );
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token =
                  await appPreference.readString(PreferenceConstants.tokenKey);
              if (token?.isNotEmpty ?? false) {
                options.headers['Authorization'] = 'Bearer $token';
                log('Bearer::::: $token');
              }
              return handler.next(options);
            },
            onResponse: (response, handler) async {
              if (kDebugMode) {
                final token = await appPreference
                    .readString(PreferenceConstants.tokenKey);

                final fields = (response.requestOptions.data != null)
                    ? response.requestOptions.data is FormData
                        ? Map.fromEntries(
                            (response.requestOptions.data as FormData).fields)
                        : response.requestOptions.data
                    : {};

                log('\nToken: $token\n${response.requestOptions.method.toUpperCase()}: ${response.requestOptions.uri}\nQuery: ${response.requestOptions.queryParameters.toString()} \nBody: ${fields.toString()} \nResponse: ${jsonEncode(response.data)}');
              }
              return handler.next(response);
            },
            onError: (exception, handler) {
              if (kDebugMode) {
                log("LOL${exception.toString()}");
              }
              if (exception.response?.statusCode == 401) {
                // add dialog session expired
              }
              return handler.next(exception);
            },
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

