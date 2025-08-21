import 'dart:convert';

import 'package:flex_travel_sim/core/platform_device/platform_detector.dart';
import 'package:flex_travel_sim/features/auth/domain/use_cases/firebase_login_use_case.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
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

  Map<String, String> buildMetadata({required String userId, String? imsi}) {
    switch (this) {
      case StripeOperationType.addFunds:
        if (imsi == null) {
          throw ArgumentError(
            'StripeService: IMSI is required for add_funds operation',
          );
        }
        return {
          'metadata[operation]': operationType,
          'metadata[userId]': userId,
          'metadata[imsi]': imsi,
        };
      case StripeOperationType.newImsi:
        return {
          'metadata[operation]': operationType,
          'metadata[userId]': userId,
        };
    }
  }
}

class StripeService {
  final FirebaseLoginUseCase _firebaseLoginUseCase;

  StripeService(this._firebaseLoginUseCase);

  String get _userId => _firebaseLoginUseCase.getCurrentUserId() ?? '';

  Future<StripePaymentResult> makePayment({
    required int amount,
    String currency = 'usd',
    required BuildContext context,
    required StripeOperationType operationType,
    String? imsi,
  }) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount: amount,
        currency: currency,
        userId: _userId,
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
          userId: _userId,
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
            testEnv: true,
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
    String currency = 'usd',
    required StripeOperationType operationType,
    String? imsi,
  }) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount: amount,
        currency: currency,
        userId: _userId,
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
        googlePay: const IsGooglePaySupportedParams(
          testEnv: true,
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
            testEnv: true,
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
    String currency = 'usd',
    required StripeOperationType operationType,
    String? imsi,
  }) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount: amount,
        currency: currency,
        userId: _userId,
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
    required String currency,
    required String userId,
    required StripeOperationType operationType,
    String? imsi,
  }) async {
    final String? stripeSecretKey = dotenv.env['STRIPE_SECRET_KEY'];
    final metadata = operationType.buildMetadata(userId: userId, imsi: imsi);
    if (kDebugMode) {
      print('StripeService: starting ${operationType.name} payment...');
      print('StripeService: Metadata - $metadata');
    }

    try {
      Map<String, dynamic>? paymentInfo = {
        "amount": _calculateAmount(amount),
        "currency": currency,
        ...metadata,
      };

      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentInfo,
        headers: {
          "Authorization": "Bearer $stripeSecretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (kDebugMode) {
        print("Stripe response status: ${response.statusCode}");
        print("response from API ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data["client_secret"] != null) {
          return data["client_secret"];
        } else {
          return null;
        }
      } else {
        if (kDebugMode) {
          print("Stripe error: ${response.statusCode} - ${response.body}");
        }
        return null;
      }
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

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
