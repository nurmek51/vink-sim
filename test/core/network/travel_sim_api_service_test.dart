import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vink_sim/core/network/api_client.dart';
import 'package:vink_sim/core/network/travel_sim_api_service.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient apiClient;
  late TravelSimApiService service;

  setUp(() {
    apiClient = MockApiClient();
    service = TravelSimApiService(apiClient: apiClient);
  });

  group('TravelSimApiService.recurrentPayment', () {
    test('sends imsi payload to /payments/recurrent with new defaults',
        () async {
      when(
        () => apiClient.post(
          any(),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => {
            'data': {'payment_id': 'p-1', 'status': 'auth'}
          });

      await service.recurrentPayment(
        imsi: 'imsi-123',
        cardId: 'card-1',
        amount: 5,
      );

      verify(
        () => apiClient.post(
          '/payments/recurrent',
          body: {
            'imsi': 'imsi-123',
            'card_id': 'card-1',
            'amount': 5,
            'description': 'Subscription',
            'currency': 'USD',
          },
        ),
      ).called(1);
    });

    test('uses legacy esim_id fallback when imsi is not provided', () async {
      when(
        () => apiClient.post(
          any(),
          body: any(named: 'body'),
        ),
      ).thenAnswer((_) async => {
            'data': {'payment_id': 'p-2', 'status': 'auth'}
          });

      await service.recurrentPayment(
        esimId: 'legacy-esim-42',
        cardId: 'card-2',
        amount: 9,
      );

      verify(
        () => apiClient.post(
          '/payments/recurrent',
          body: {
            'esim_id': 'legacy-esim-42',
            'card_id': 'card-2',
            'amount': 9,
            'description': 'Subscription',
            'currency': 'USD',
          },
        ),
      ).called(1);
    });

    test('throws when both imsi and esim_id are missing', () async {
      expect(
        () => service.recurrentPayment(
          cardId: 'card-3',
          amount: 10,
        ),
        throwsA(isA<ArgumentError>()),
      );

      verifyNever(
        () => apiClient.post(
          any(),
          body: any(named: 'body'),
        ),
      );
    });
  });
}
