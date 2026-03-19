import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vink_sim/features/payment/domain/repositories/payment_repository.dart';
import 'package:vink_sim/features/payment/presentation/bloc/payment_bloc.dart';

class MockPaymentRepository extends Mock implements PaymentRepository {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockPaymentRepository paymentRepository;
  late BuildContext buildContext;

  setUp(() {
    paymentRepository = MockPaymentRepository();
    buildContext = MockBuildContext();
  });

  group('PaymentBloc recurrent saved-card flow', () {
    blocTest<PaymentBloc, PaymentState>(
      'uses recurrent payment first when a saved card is selected',
      build: () {
        when(
          () => paymentRepository.recurrentPayment(
            imsi: any(named: 'imsi'),
            cardId: any(named: 'cardId'),
            amount: any(named: 'amount'),
          ),
        ).thenAnswer(
          (_) async => const RecurrentPaymentResult(
            paymentId: 'recurrent-1',
            status: 'auth',
            requires3ds: false,
          ),
        );

        return PaymentBloc(paymentRepository: paymentRepository);
      },
      act: (bloc) => bloc.add(
        PaymentRequested(
          amount: 5,
          context: buildContext,
          operationType: PaymentOperationType.addFunds,
          imsi: 'imsi-001',
          preferredCardId: 'saved-card-11',
          autoTopUpEnabled: false,
        ),
      ),
      expect: () => [
        isA<PaymentLoading>(),
        isA<PaymentCompleted>()
            .having((state) => state.paymentId, 'paymentId', 'recurrent-1')
            .having((state) => state.status, 'status', 'auth'),
      ],
      verify: (_) {
        verify(
          () => paymentRepository.recurrentPayment(
            imsi: 'imsi-001',
            cardId: 'saved-card-11',
            amount: 5,
          ),
        ).called(1);
      },
    );
  });
}
