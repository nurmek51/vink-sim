import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flex_travel_sim/core/error/exceptions.dart';
import 'package:flex_travel_sim/core/network/auth_interceptor.dart';
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

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    
    try {
      http.Response response;
      
      if (_authInterceptor != null) {
        final request = http.Request('GET', uri);
        request.headers.addAll(_buildHeaders(headers));
        response = await _authInterceptor.send(request);
      } else {
        response = await _client.get(
          uri,
          headers: _buildHeaders(headers),
        );
      }
      
      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } on http.ClientException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      throw NetworkException('Unexpected error: $e');
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final requestHeaders = _buildHeaders(headers);
    final requestBody = body != null ? jsonEncode(body) : null;
    
    if (kDebugMode) {
      print('API Request: POST $uri');
      print('Headers: $requestHeaders');
      print('Body: $requestBody');
    }
    
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
      
      if (kDebugMode) {
        print('API Response: ${response.statusCode}');
        print('Response headers: ${response.headers}');
        print('Response body: ${response.body}');
      }
      
      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } on http.ClientException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      if (kDebugMode) {
        print('API Error: $e');
      }
      throw NetworkException('Unexpected error: $e');
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final requestHeaders = _buildHeaders(headers);
    final requestBody = body != null ? jsonEncode(body) : null;
    
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
      
      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } on http.ClientException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      throw NetworkException('Unexpected error: $e');
    }
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    final requestHeaders = _buildHeaders(headers);
    
    try {
      http.Response response;
      
      if (_authInterceptor != null) {
        final request = http.Request('DELETE', uri);
        request.headers.addAll(requestHeaders);
        response = await _authInterceptor.send(request);
      } else {
        response = await _client.delete(
          uri,
          headers: requestHeaders,
        );
      }
      
      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } on http.ClientException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } catch (e) {
      throw NetworkException('Unexpected error: $e');
    }
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    final uri = Uri.parse('$baseUrl$endpoint');
    
    if (queryParameters != null && queryParameters.isNotEmpty) {
      return uri.replace(queryParameters: queryParameters.map(
        (key, value) => MapEntry(key, value.toString()),
      ));
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

  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    
    if (statusCode >= 200 && statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }
      
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw const ServerException('Invalid JSON response');
      }
    }
    
    String errorMessage;
    try {
      final errorJson = jsonDecode(response.body) as Map<String, dynamic>;
      errorMessage = errorJson['message'] ?? 'Unknown server error';
    } catch (e) {
      errorMessage = 'Server error: ${response.reasonPhrase}';
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

  void dispose() {
    _authInterceptor?.dispose();
    _client.close();
  }
}
