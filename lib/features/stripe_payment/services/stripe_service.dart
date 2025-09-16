import 'package:flex_travel_sim/core/config/environment.dart';
import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flex_travel_sim/core/platform_device/platform_detector.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flex_travel_sim/features/auth/domain/use_cases/firebase_login_use_case.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flex_travel_sim/features/stripe_payment/utils/stripe_web.dart';

enum StripePaymentResult { success, cancelled, failure, redirectedToWeb }

enum StripeOperationType {
  addFunds,
  newImsi;

  String get operationType {
    switch (this) {
      case StripeOperationType.addFunds:
        return 'add_funds';
      case StripeOperationType.newImsi:
        return 'new_imsi';
    }
  }

}

class StripeService {
  final FirebaseLoginUseCase firebaseLoginUseCase;
  final ApiClient apiClient;
  final AuthLocalDataSource localDataSource;

  StripeService({
    required this.firebaseLoginUseCase,
    required this.apiClient,
    required this.localDataSource,
  });

  Future<StripePaymentResult> makePayment({
    required int amount,
    required BuildContext context,
    required StripeOperationType operationType,
    String? imsi,
  }) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount: amount,
        operationType: operationType,
        imsi: imsi,
      );
      if (paymentIntentClientSecret == null) return StripePaymentResult.failure;

      if (kDebugMode) {
        print(
          "StripeService: Операция ${operationType.name} успешно инициирована",
        );
      }

      if (kIsWeb && context.mounted) {
        NavigationService.openStripeWebCheckoutPage(
          context,
          clientSecret: paymentIntentClientSecret,
          amount: amount,
          imsi: imsi,
          operationType: operationType,
        );

        return StripePaymentResult.redirectedToWeb;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "FlexTravelSIM",
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            currencyCode: 'USD',
            testEnv: Environment.isDevelopment,
          ),
          applePay: PaymentSheetApplePay(merchantCountryCode: 'US'),
        ),
      );
      return await _proccessPayment();
    } catch (e) {
      if (kDebugMode) print(e);
      return StripePaymentResult.failure;
    }
  }

  Future<StripePaymentResult> confirmWebPayment({
    required String clientSecret,
    required String returnUrl,
    String? imsi,
  }) async {
    try {
      await WebStripe.instance.confirmPaymentElement(
        ConfirmPaymentElementOptions(
          redirect: PaymentConfirmationRedirect.ifRequired,
          confirmParams: ConfirmPaymentParams(return_url: returnUrl),
        ),
      );
      return StripePaymentResult.success;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        if (kDebugMode) print('Web Stripe Canceled by user');
        return StripePaymentResult.cancelled;
      }
      return StripePaymentResult.failure;
    } catch (e) {
      if (kDebugMode) print('Web Stripe Unknown Error $e');
      return StripePaymentResult.failure;
    }
  }

  Future<StripePaymentResult> makeGooglePayOnlyPayment({
    required int amount,
    required StripeOperationType operationType,
    String? imsi,
  }) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount: amount,
        operationType: operationType,
        imsi: imsi,
      );
      if (paymentIntentClientSecret == null) return StripePaymentResult.failure;

      if (kDebugMode) {
        print(
          "StripeService: Операция ${operationType.name} успешно инициирована",
        );
      }

      final supported = await Stripe.instance.isPlatformPaySupported(
        googlePay: IsGooglePaySupportedParams(
          testEnv: Environment.isDevelopment,
          existingPaymentMethodRequired: false,
        ),
      );

      if (!supported) {
        if (kDebugMode) {
          print('Google Pay не поддерживается на этом устройстве');
        }
        return StripePaymentResult.failure;
      }

      await Stripe.instance.confirmPlatformPayPaymentIntent(
        clientSecret: paymentIntentClientSecret,
        confirmParams: PlatformPayConfirmParams.googlePay(
          googlePay: GooglePayParams(
            merchantName: 'FlexTravelSim',
            merchantCountryCode: 'US',
            currencyCode: 'USD',
            testEnv: Environment.isDevelopment,
          ),
        ),
      );

      return StripePaymentResult.success;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        if (kDebugMode) print('Google Pay cancelled by user');
        return StripePaymentResult.cancelled;
      } else {
        if (kDebugMode) print('StripeException during GPay: $e');
        return StripePaymentResult.failure;
      }
    } catch (e) {
      if (kDebugMode) print('Unknown error during GPay: $e');
      return StripePaymentResult.failure;
    }
  }

  Future<StripePaymentResult> makeApplePayPayment({
    required int amount,
    required StripeOperationType operationType,
    String? imsi,
  }) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount: amount,
        operationType: operationType,
        imsi: imsi,
      );
      if (paymentIntentClientSecret == null) return StripePaymentResult.failure;

      if (kDebugMode) {
        print(
          "StripeService: Apple Pay операция ${operationType.name} успешно инициирована",
        );
      }

      // Check if running on simulator
      if (PlatformDetector.isSimulator) {
        if (kDebugMode) {
          print(
            'Apple Pay не работает на симуляторе iOS. Требуется реальное устройство iPhone с настроенными картами в Wallet.',
          );
        }
        return StripePaymentResult.failure;
      }

      final supported = await Stripe.instance.isPlatformPaySupported();

      if (kDebugMode) {
        print('Apple Pay supported: $supported');
        print(
          'Device: ${!PlatformDetector.isSimulator ? "Real iPhone" : "Simulator"}',
        );
      }

      if (!supported) {
        if (kDebugMode) {
          print(
            'isPlatformPaySupported() returned false, but Apple Pay might still work...',
          );
        }
      }

      if (kDebugMode) {
        print('Attempting Apple Pay with amount: \$$amount.00');
        print('Merchant: merchant.com.flextravelsim.app');
      }

      await Stripe.instance.confirmPlatformPayPaymentIntent(
        clientSecret: paymentIntentClientSecret,
        confirmParams: PlatformPayConfirmParams.applePay(
          applePay: ApplePayParams(
            cartItems: [
              ApplePayCartSummaryItem.immediate(
                label: 'FlexTravelSIM',
                amount: amount.toStringAsFixed(2),
              ),
            ],
            merchantCountryCode: 'US',
            currencyCode: 'USD',
          ),
        ),
      );

      return StripePaymentResult.success;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        if (kDebugMode) {
          print(
            'Apple Pay cancelled - this might be automatic cancellation due to:',
          );
          print(
            '- Missing/invalid merchant certificates in Apple Developer Console',
          );
          print('- Merchant ID not properly configured');
          print('- Card restrictions or region issues');
          print('StripeException details: $e');
        }
        return StripePaymentResult.cancelled;
      } else {
        if (kDebugMode) print('StripeException during Apple Pay: $e');
        return StripePaymentResult.failure;
      }
    } catch (e) {
      if (kDebugMode) print('Unknown error during Apple Pay: $e');
      return StripePaymentResult.failure;
    }
  }

  Future<String?> _createPaymentIntent({
    required int amount,
    required StripeOperationType operationType,
    String? imsi,
  }) async {
    final token = await localDataSource.getToken();
    if (kDebugMode) {
      print('StripeService: starting ${operationType.name} payment...');
    }

    try {
      Map<String, dynamic>? paymentInfo = {
        "operation": operationType.operationType,
        "amount": amount
      };

      if (operationType == StripeOperationType.addFunds) {
        if (imsi == null) {
          throw ArgumentError(
            "StripeService: IMSI is required for add_funds operation",
          );
        }
        paymentInfo["imsi"] = imsi;
      }

      final response = await apiClient.post(
        "/stripe/payment",
        body: paymentInfo,
        headers: {
          if (token != null) "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      final String? clientSecret = response['client_secret'];

      if (kDebugMode) {
        print("Stripe (/stripe/payment) response from API $response");
      }

      return clientSecret;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<StripePaymentResult> _proccessPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return StripePaymentResult.success;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        if (kDebugMode) print('Payment cancelled by user');
        return StripePaymentResult.cancelled;
      } else {
        if (kDebugMode) print('StripeException: $e');
        return StripePaymentResult.failure;
      }
    } catch (e) {
      if (kDebugMode) print('Unknown error during payment: $e');
      return StripePaymentResult.failure;
    }
  }

}
