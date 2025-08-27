import 'package:http/http.dart' as http;
import 'package:flex_travel_sim/core/services/token_manager.dart';
import 'package:flutter/foundation.dart';

class AuthInterceptor {
  final TokenManager _tokenManager;
  final http.Client _innerClient;
  bool _isRefreshing = false;

  AuthInterceptor({
    required TokenManager tokenManager,
    http.Client? innerClient,
  }) : _tokenManager = tokenManager,
       _innerClient = innerClient ?? http.Client();

  Future<http.Response> send(http.BaseRequest request) async {
    final publicEndpoints = ['/otp/', '/api/login/'];

    final isPublicEndpoint = publicEndpoints.any(
      (endpoint) => request.url.path.contains(endpoint),
    );

    if (!isPublicEndpoint) {
      final token = await _tokenManager.getCurrentIdToken();

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';

        if (kDebugMode) {
          print(
            'AuthInterceptor: Added token to protected endpoint: ${request.url.path}',
          );
          print('AuthInterceptor: Token: ${token.substring(0, 20)}...');
        }
      } else {
        if (kDebugMode) {
          print(
            'AuthInterceptor: No token available for protected endpoint: ${request.url.path}',
          );
        }
      }
    } else {
      if (kDebugMode) {
        print(
          'AuthInterceptor: Skipping token for public endpoint: ${request.url.path}',
        );
      }
    }

    final streamedResponse = await _innerClient.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 401 && !isPublicEndpoint && !_isRefreshing) {
      if (kDebugMode) {
        print(
          'AuthInterceptor: 401 error detected on protected endpoint, attempting token refresh',
        );
      }

      _isRefreshing = true;

      try {
        final newToken = await _tokenManager.refreshIdTokenManually();

        if (newToken != null) {
          if (kDebugMode) {
            print(
              'AuthInterceptor: Token refreshed successfully, retrying request',
            );
          }

          final retryRequest = _copyRequest(request);
          retryRequest.headers['Authorization'] = 'Bearer $newToken';

          final retryStreamedResponse = await _innerClient.send(retryRequest);
          final retryResponse = await http.Response.fromStream(
            retryStreamedResponse,
          );

          if (kDebugMode) {
            print(
              'AuthInterceptor: Retry response status: ${retryResponse.statusCode}',
            );
          }

          _isRefreshing = false;
          return retryResponse;
        } else {
          if (kDebugMode) {
            print(
              'AuthInterceptor: Failed to get new token, returning original 401 response',
            );
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('AuthInterceptor: Failed to refresh token: $e');
        }
      } finally {
        _isRefreshing = false;
      }
    }

    return response;
  }

  http.BaseRequest _copyRequest(http.BaseRequest original) {
    http.BaseRequest request;

    if (original is http.Request) {
      request = http.Request(original.method, original.url)
        ..body = original.body;
    } else if (original is http.MultipartRequest) {
      request =
          http.MultipartRequest(original.method, original.url)
            ..fields.addAll(original.fields)
            ..files.addAll(original.files);
    } else {
      throw ArgumentError('Request type not supported');
    }

    request.headers.addAll(original.headers);
    return request;
  }

  void dispose() {
    _innerClient.close();
  }
}
