import 'dart:io';
import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  const ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
            'Connection timeout. Please check your internet and try again');

      case DioExceptionType.sendTimeout:
        return const ServerFailure('Request timeout. Please try again');

      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Server response timeout. Please try again');

      case DioExceptionType.badCertificate:
        return const ServerFailure('Security certificate error');

      case DioExceptionType.cancel:
        return const ServerFailure('Request cancelled');

      case DioExceptionType.badResponse:
        return ServerFailure._fromResponse(dioError.response);

      case DioExceptionType.connectionError:
        if (dioError.error is SocketException) {
          final socketError = dioError.error as SocketException;
          if (socketError.osError?.errorCode == 104 ||
              socketError.message.contains('Connection reset')) {
            return const ServerFailure(
                'Connection lost. Please check your internet and try again');
          }
          if (socketError.osError?.errorCode == 111) {
            return const ServerFailure(
                'Cannot reach server. Please try again later');
          }
        }
        return const ServerFailure('No internet connection');

      case DioExceptionType.unknown:
      default:
        if (dioError.error is SocketException) {
          final socketError = dioError.error as SocketException;
          if (socketError.osError?.errorCode == 104 ||
              socketError.message.contains('Connection reset')) {
            return const ServerFailure('Connection lost. Please try again');
          }
        }
        if (dioError.message?.contains('Connection reset') ?? false) {
          return const ServerFailure('Connection lost. Please try again');
        }
        return const ServerFailure('Something went wrong. Please try again');
    }
  }

  // Helper method لمعالجة bad response
  static ServerFailure _fromResponse(Response? response) {
    if (response == null) {
      return const ServerFailure('No response from server');
    }

    final statusCode = response.statusCode;
    final responseData = response.data;

    // محاولة استخراج رسالة الخطأ من الـ response
    String message = 'Error occurred';

    if (responseData is Map<String, dynamic>) {
      message = responseData['message']?.toString() ??
          responseData['error']?.toString() ??
          'Received invalid status code: $statusCode';
    } else if (responseData is String && responseData.isNotEmpty) {
      message = responseData;
    } else {
      // رسائل افتراضية حسب status code
      switch (statusCode) {
        case 400:
          message = 'Bad request';
          break;
        case 401:
          message = 'Unauthorized access';
          break;
        case 403:
          message = 'Access forbidden';
          break;
        case 404:
          message = 'Resource not found';
          break;
        case 429:
          message = 'Too many requests. Please try again later';
          break;
        case 500:
          message = 'Internal server error';
          break;
        case 502:
          message = 'Bad gateway';
          break;
        case 503:
          message = 'Service unavailable';
          break;
        case 504:
          message = 'Gateway timeout';
          break;
        default:
          message = 'Error $statusCode occurred';
      }
    }

    return ServerFailure(message);
  }
}
