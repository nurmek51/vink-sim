import 'package:vink_sim/core/utils/result.dart';

abstract class NetworkService {
  Future<Result<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  Future<Result<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future<Result<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future<Result<T>> delete<T>(String endpoint, {Map<String, String>? headers});

  Future<Result<T>> patch<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}
