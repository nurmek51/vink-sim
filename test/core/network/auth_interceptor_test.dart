import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:vink_sim/core/network/auth_interceptor.dart';
import 'package:vink_sim/core/services/token_manager.dart';

class MockTokenManager extends Mock implements TokenManager {}

class MockClient extends Mock implements http.Client {}

void main() {
  late AuthInterceptor interceptor;
  late MockTokenManager mockTokenManager;
  late MockClient mockClient;
  const baseUrl = 'http://api.example.com/api/v1';

  setUpAll(() {
    registerFallbackValue(Uri.parse('http://api.example.com'));
    registerFallbackValue(
        http.Request('GET', Uri.parse('http://api.example.com')));
  });

  setUp(() {
    mockTokenManager = MockTokenManager();
    mockClient = MockClient();
    interceptor = AuthInterceptor(
      tokenManager: mockTokenManager,
      innerClient: mockClient,
      baseUrl: baseUrl,
    );
  });

  group('AuthInterceptor', () {
    test('should add Authorization header if token is available', () async {
      // arrange
      const token = 'test_token';
      when(() => mockTokenManager.getCurrentIdToken())
          .thenAnswer((_) async => token);

      final request = http.Request('GET', Uri.parse('$baseUrl/protected'));

      when(() => mockClient.send(any()))
          .thenAnswer((_) async => http.StreamedResponse(
                Stream.value(utf8.encode('{}')),
                200,
              ));

      // act
      await interceptor.send(request);

      // assert
      verify(() => mockClient.send(any(
          that: isA<http.BaseRequest>().having(
              (r) => r.headers['Authorization'],
              'Authorization',
              'Bearer $token')))).called(1);
    });

    test('should attempt token refresh on 401 error', () async {
      // arrange
      const oldToken = 'old_token';
      const refreshToken = 'refresh_token';
      const newToken = 'new_token';

      when(() => mockTokenManager.getCurrentIdToken())
          .thenAnswer((_) async => oldToken);
      when(() => mockTokenManager.getRefreshToken())
          .thenAnswer((_) async => refreshToken);
      when(() => mockTokenManager.saveTokens(any(), any()))
          .thenAnswer((_) async => {});

      // First request fails with 401
      var callCount = 0;
      when(() => mockClient.send(any())).thenAnswer((invocation) async {
        callCount++;
        if (callCount == 1) {
          // Initial request
          return http.StreamedResponse(Stream.value(utf8.encode('{}')), 401);
        } else if (callCount == 2) {
          // Refresh request
          return http.StreamedResponse(
              Stream.value(utf8.encode(jsonEncode({
                'success': true,
                'data': {
                  'access_token': newToken,
                  'refresh_token': 'new_refresh',
                  'expires_in': 3600
                }
              }))),
              200);
        } else {
          // Retry request
          return http.StreamedResponse(
              Stream.value(utf8.encode('{"success": true}')), 200);
        }
      });

      final request = http.Request('GET', Uri.parse('$baseUrl/protected'));

      // act
      final response = await interceptor.send(request);

      // assert
      expect(response.statusCode, 200);
      expect(callCount, 3); // Initial + Refresh + Retry
      verify(() => mockTokenManager.saveTokens(newToken, 'new_refresh'))
          .called(1);
    });
  });
}
