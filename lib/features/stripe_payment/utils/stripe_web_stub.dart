import 'package:flutter/widgets.dart';

class WebStripe {
  static final instance = WebStripe();
  Future<void> confirmPaymentElement(ConfirmPaymentElementOptions options) async {}
}

class ConfirmPaymentElementOptions {
  final PaymentConfirmationRedirect redirect;
  final ConfirmPaymentParams confirmParams;

  ConfirmPaymentElementOptions({
    required this.redirect,
    required this.confirmParams,
  });
}

enum PaymentConfirmationRedirect {
  ifRequired,
}

class ConfirmPaymentParams {
  // ignore: non_constant_identifier_names
  final String return_url;

  // ignore: non_constant_identifier_names
  ConfirmPaymentParams({required this.return_url});
}

class PaymentElement extends StatelessWidget {
  final String clientSecret;
  final bool enablePostalCode;
  final bool autofocus;
  final ValueChanged<dynamic>? onCardChanged;

  const PaymentElement({
    required this.clientSecret,
    this.enablePostalCode = false,
    this.autofocus = false,
    this.onCardChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
