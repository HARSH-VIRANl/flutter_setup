import 'dart:async';
import 'package:core/core_exports.dart';

abstract class BaseApiProvider {
  Future<Response> postMethod(
    String url,
    Map<String, dynamic> body, {
    String? contentType,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future<Response> getMethod(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
  });

  Future<Response> putMethod(
    String url,
    Map<String, dynamic> body, {
    String? contentType,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future<Response> patchMethod(
    String url,
    Map<String, dynamic> body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  });

  Future<Response> deleteMethod(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
  });

  Future<Response> uploadImage<T>(
    String url,
    FormData formData, {
    String? contentType,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });
}

class APIProvider extends BaseApiProvider {
  final Dio dio;
  final NetworkProvider networkProvider;

  APIProvider({required this.dio, required this.networkProvider});

  @override
  Future<Response> deleteMethod(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
  }) async {
    if (await networkProvider.hasInternetConnection()) {
      return dio.delete(url, queryParameters: query);
    } else {
      throw CustomException(S.current.noInternetConnection);
    }
  }

  @override
  Future<Response> getMethod(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
  }) async {
    if (await networkProvider.hasInternetConnection()) {
      return dio.get(url, queryParameters: query);
    } else {
      throw CustomException(S.current.noInternetConnection);
    }
  }

  @override
  Future<Response> patchMethod(
    String url,
    Map<String, dynamic> body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    if (await networkProvider.hasInternetConnection()) {
      return dio.patch(url, queryParameters: query);
    } else {
      throw CustomException(S.current.noInternetConnection);
    }
  }

  @override
  Future<Response> putMethod(
    String url,
    Map<String, dynamic> body, {
    String? contentType,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (await networkProvider.hasInternetConnection()) {
      return dio.put(
        url,
        queryParameters: query,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: options,
      );
    } else {
      throw CustomException(S.current.noInternetConnection);
    }
  }

  @override
  Future<Response> postMethod(
    String url,
    Map<String, dynamic> body, {
    String? contentType,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (await networkProvider.hasInternetConnection()) {
      return dio.post(
        url,
        queryParameters: query,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: options,
      );
    } else {
      throw CustomException(S.current.noInternetConnection);
    }
  }

  @override
  Future<Response> uploadImage<T>(
    String url,
    FormData formData, {
    String? contentType,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (await networkProvider.hasInternetConnection()) {
      return dio.post(
        url,
        queryParameters: query,
        data: formData,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: options,
      );
    } else {
      throw CustomException(S.current.noInternetConnection);
    }
  }
}
