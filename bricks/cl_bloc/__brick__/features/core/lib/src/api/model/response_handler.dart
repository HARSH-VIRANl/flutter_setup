// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'response_handler.g.dart';

@JsonSerializable()
class ResponseHandler {
  bool? error;
  int? status;
  String? message;
  dynamic result;
  int httpStatus;
  String? token;

  static bool _isSuccess(int value) {
    return value == 200;
  }

  bool get isSuccess =>
      (_isSuccess(status ?? 0) && _isSuccess(httpStatus)) && !(error ?? true);

  ResponseHandler({
    this.httpStatus = 200,
    this.error,
    this.status,
    this.message,
    this.result,
    this.token,
  });

  factory ResponseHandler.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey('result') || json.containsKey('status')) {
        return ResponseHandler.fromJsonHidden(json);
      } else {
        return ResponseHandler(
          status: 200,
          httpStatus: 200,
          error: false,
          message: 'Success',
          result: json,
        );
      }
    } else if (json is List) {
      return ResponseHandler(
        status: 200,
        httpStatus: 200,
        error: false,
        message: 'Success',
        result: {'totalClients': json.length, 'users': json},
      );
    } else {
      return ResponseHandler(
        status: 500,
        result: null,
        message: 'Unable to complete this request',
        error: true,
        httpStatus: 500,
      );
    }
  }

  factory ResponseHandler.fromJsonHidden(Map<String, dynamic> json) =>
      _$ResponseHandlerFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseHandlerToJson(this);
}
