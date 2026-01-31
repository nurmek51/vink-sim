import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vink_sim/core/error/exceptions.dart';
import 'package:vink_sim/core/network/auth_interceptor.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  final AuthInterceptor? _authInterceptor;
  final http.Client _client;
  final String baseUrl;

  ApiClient({
    required this.baseUrl,
    AuthInterceptor? authInterceptor,
    http.Client? client,
  }) : _authInterceptor = authInterceptor,
       _client = client ?? http.Client();

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final requestHeaders = _buildHeaders(headers);

    _logRequest('GET', uri, requestHeaders);

    try {
      http.Response response;

      if (_authInterceptor != null) {
        final request = http.Request('GET', uri);
        request.headers.addAll(requestHeaders);
        response = await _authInterceptor.send(request);
      } else {
        response = await _client.get(uri, headers: requestHeaders);
      }

      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        if (kDebugMode) print('❌ No internet connection');
        throw const NetworkException('No internet connection');
      }
      if (e is http.ClientException) {
        if (kDebugMode) print('❌ Network error: ${e.message}');
        throw NetworkException('Network error: ${e.message}');
      }
      if (kDebugMode) print('❌ Unexpected error: $e');
      throw NetworkException('Unexpected error: $e');
    }
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final requestHeaders = _buildHeaders(headers);
    final requestBody = body != null ? jsonEncode(body) : null;

    _logRequest('POST', uri, requestHeaders, requestBody);

    try {
      http.Response response;

      if (_authInterceptor != null) {
        final request = http.Request('POST', uri);
        request.headers.addAll(requestHeaders);
        if (requestBody != null) {
          request.body = requestBody;
        }
        response = await _authInterceptor.send(request);
      } else {
        response = await _client.post(
          uri,
          headers: requestHeaders,
          body: requestBody,
        );
      }

      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        if (kDebugMode) print('❌ No internet connection');
        throw const NetworkException('No internet connection');
      }
      if (e is http.ClientException) {
        if (kDebugMode) print('❌ Network error: ${e.message}');
        throw NetworkException('Network error: ${e.message}');
      }
      if (kDebugMode) print('❌ Unexpected error: $e');
      throw NetworkException('Unexpected error: $e');
    }
  }

  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final requestHeaders = _buildHeaders(headers);
    final requestBody = body != null ? jsonEncode(body) : null;

    _logRequest('PUT', uri, requestHeaders, requestBody);

    try {
      http.Response response;

      if (_authInterceptor != null) {
        final request = http.Request('PUT', uri);
        request.headers.addAll(requestHeaders);
        if (requestBody != null) {
          request.body = requestBody;
        }
        response = await _authInterceptor.send(request);
      } else {
        response = await _client.put(
          uri,
          headers: requestHeaders,
          body: requestBody,
        );
      }

      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        if (kDebugMode) print('❌ No internet connection');
        throw const NetworkException('No internet connection');
      }
      if (e is http.ClientException) {
        if (kDebugMode) print('❌ Network error: ${e.message}');
        throw NetworkException('Network error: ${e.message}');
      }
      if (kDebugMode) print('❌ Unexpected error: $e');
      throw NetworkException('Unexpected error: $e');
    }
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final requestHeaders = _buildHeaders(headers);

    _logRequest('DELETE', uri, requestHeaders);

    try {
      http.Response response;

      if (_authInterceptor != null) {
        final request = http.Request('DELETE', uri);
        request.headers.addAll(requestHeaders);
        response = await _authInterceptor.send(request);
      } else {
        response = await _client.delete(uri, headers: requestHeaders);
      }

      _logResponse(response);
      return _handleResponse(response);
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        if (kDebugMode) print('❌ No internet connection');
        throw const NetworkException('No internet connection');
      }
      if (e is http.ClientException) {
        if (kDebugMode) print('❌ Network error: ${e.message}');
        throw NetworkException('Network error: ${e.message}');
      }
      if (kDebugMode) print('❌ Unexpected error: $e');
      throw NetworkException('Unexpected error: $e');
    }
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    // Remove trailing slash from baseUrl if present to avoid double slashes
    final cleanBaseUrl =
        baseUrl.endsWith('/')
            ? baseUrl.substring(0, baseUrl.length - 1)
            : baseUrl;
    // Ensure endpoint starts with slash
    final cleanEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';

    final uri = Uri.parse('$cleanBaseUrl$cleanEndpoint');

    if (queryParameters != null && queryParameters.isNotEmpty) {
      return uri.replace(
        queryParameters: queryParameters.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      );
    }

    return uri;
  }

  Map<String, String> _buildHeaders(Map<String, String>? additionalHeaders) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }

      try {
        // Changed to dynamic to support both Map and List responses
        return jsonDecode(response.body);
      } catch (e) {
        throw const ServerException('Invalid JSON response');
      }
    }

    String errorMessage;
    try {
      final errorJson = jsonDecode(response.body) as Map<String, dynamic>;
      errorMessage = errorJson['message'] ?? 'Unknown server error';
    } catch (e) {
      errorMessage =
          response.body.isNotEmpty
              ? response.body
              : 'Server error: ${response.reasonPhrase}';
    }

    switch (statusCode) {
      case 400:
        throw ValidationException(errorMessage);
      case 401:
        throw AuthenticationException(errorMessage);
      case 404:
        throw NotFoundException(errorMessage);
      case >= 500:
        throw ServerException(errorMessage, statusCode: statusCode);
      default:
        throw ServerException(errorMessage, statusCode: statusCode);
    }
  }

  void _logRequest(
    String method,
    Uri uri,
    Map<String, String> headers, [
    String? body,
  ]) {
    if (!kDebugMode) return;
    const separator =
        '──────────────────────────────────────────────────────────────────';
    print('┌$separator');
    print('│ 🚀 API Request: $method $uri');
    print('│ Headers: $_sanitizeHeaders(headers)');
    if (body != null) {
      try {
        final jsonBody = jsonDecode(body);
        final prettyBody = const JsonEncoder.withIndent('  ').convert(jsonBody);
        print('│ Body: \n$prettyBody');
      } catch (_) {
        print('│ Body: $body');
      }
    }
    print('└$separator');
  }

  void _logResponse(http.Response response) {
    if (!kDebugMode) return;
    const separator =
        '──────────────────────────────────────────────────────────────────';
    final isError = response.statusCode >= 400;
    final icon = isError ? '❌' : '✅';

    print('┌$separator');
    print(
      '│ $icon API Response: ${response.statusCode} (${response.reasonPhrase})',
    );
    print('│ URL: ${response.request?.url}');

    // Log body with pretty printing
    String body = response.body;
    if (body.isNotEmpty) {
      try {
        final jsonBody = jsonDecode(body);
        final prettyBody = const JsonEncoder.withIndent('  ').convert(jsonBody);
        // Truncate if extremely long (e.g. > 100 lines)
        final lines = prettyBody.split('\n');
        if (lines.length > 100) {
          final topLines = lines.take(20).join('\n');
          final bottomLines = lines.skip(lines.length - 20).join('\n');
          print(
            '│ Body: \n$topLines\n  ... (${lines.length - 40} lines omitted) ...\n$bottomLines',
          );
        } else {
          print('│ Body: \n$prettyBody');
        }
      } catch (_) {
        if (body.length > 3000) {
          body = '${body.substring(0, 3000)}... (truncated)';
        }
        print('│ Body: $body');
      }
    }
    print('└$separator');
  }

  Map<String, String> _sanitizeHeaders(Map<String, String> headers) {
    if (!headers.containsKey('Authorization')) return headers;
    final sanitized = Map<String, String>.from(headers);
    if (sanitized['Authorization'] != null &&
        sanitized['Authorization']!.length > 15) {
      sanitized['Authorization'] =
          '${sanitized['Authorization']!.substring(0, 15)}...';
    }
    return sanitized;
  }

  void dispose() {
    _authInterceptor?.dispose();
    _client.close();
  }
}
