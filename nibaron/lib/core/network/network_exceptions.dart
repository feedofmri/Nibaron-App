import 'package:dio/dio.dart';

class NetworkExceptions implements Exception {
  final String message;
  final int? statusCode;

  NetworkExceptions(this.message, [this.statusCode]);

  static NetworkExceptions fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkExceptions('Connection timeout. Please check your internet connection.');

      case DioExceptionType.badResponse:
        return NetworkExceptions(
          _handleStatusCode(dioException.response?.statusCode),
          dioException.response?.statusCode,
        );

      case DioExceptionType.cancel:
        return NetworkExceptions('Request cancelled');

      case DioExceptionType.connectionError:
        return NetworkExceptions('No internet connection. Please check your network settings.');

      case DioExceptionType.badCertificate:
        return NetworkExceptions('Certificate error. Please check your connection security.');

      case DioExceptionType.unknown:
      default:
        return NetworkExceptions('Something went wrong. Please try again.');
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Access forbidden. You don\'t have permission.';
      case 404:
        return 'Resource not found.';
      case 500:
        return 'Server error. Please try again later.';
      case 502:
        return 'Bad gateway. Service temporarily unavailable.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => message;
}
