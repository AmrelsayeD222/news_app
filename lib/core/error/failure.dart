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
        return const ServerFailure('Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send timeout with API server');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive timeout with API server');
      case DioExceptionType.badCertificate:
        return const ServerFailure('Bad certificate from API server');
      case DioExceptionType.cancel:
        return const ServerFailure('Request to API server was cancelled');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response?.statusCode, dioError.response?.data);
      case DioExceptionType.connectionError:
        return const ServerFailure('No Internet connection');
      case DioExceptionType.unknown:
      default:
        return const ServerFailure('Unexpected error, please try again later');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == null) return const ServerFailure('Unknown error');
    switch (statusCode) {
      case 400:
        return const ServerFailure('Bad request, please try again');
      case 401:
        return const ServerFailure('Unauthorized access');
      case 403:
        return const ServerFailure('Forbidden request');
      case 404:
        return const ServerFailure('Resource not found');
      case 500:
        return const ServerFailure('Internal server error');
      default:
        return ServerFailure('Error $statusCode: ${response.toString()}');
    }
  }
}
