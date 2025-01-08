import 'dart:io';

import 'package:dio/dio.dart';

class ExceptionHandler {
  static ApiException handleException(dynamic error) {
    try {
      // Xử lý Dio errors
      if (error is DioException) {
        return ApiException(
          errorCode: error.response?.statusCode ?? -1,
          errorMessage: error.response?.statusMessage ?? 'Dio Error',
          errorStatus: error.response?.statusCode.toString() ?? 'UNKNOWN_ERROR',
          originalException: error,
        );
      }

      // Xử lý các ngoại lệ mạng khác
      if (error is SocketException) {
        return ApiException(
          errorCode: -1,
          errorMessage: 'Không có kết nối mạng',
          errorStatus: 'NETWORK_ERROR',
          originalException: error,
        );
      }

      // Xử lý các ngoại lệ HTTP
      if (error is HttpException) {
        return ApiException(
          errorCode: -2,
          errorMessage: 'Lỗi kết nối HTTP',
          errorStatus: 'HTTP_ERROR',
          originalException: error,
        );
      }

      // Xử lý các ngoại lệ không xác định
      return ApiException(
        errorCode: -3,
        errorMessage: error.toString(),
        errorStatus: 'UNKNOWN_ERROR',
        originalException: error,
      );
    } catch (e) {
      // Trường hợp xử lý ngoại lệ bị lỗi
      return ApiException(
        errorCode: -4,
        errorMessage: 'Lỗi không xác định khi xử lý ngoại lệ',
        errorStatus: 'EXCEPTION_HANDLING_ERROR',
        originalException: e,
      );
    }
  }
}

class ApiException implements Exception {
  final int? errorCode;
  final String? errorMessage;
  final String? errorStatus;
  final dynamic originalException;

  ApiException({
    this.errorCode,
    this.errorMessage,
    required this.errorStatus,
    this.originalException,
  });

  @override
  String toString() {
    return 'ApiException: '
        'errorCode=$errorCode, '
        'errorMessage=$errorMessage, '
        'errorStatus=$errorStatus, '
        'originalException=$originalException';
  }
}
