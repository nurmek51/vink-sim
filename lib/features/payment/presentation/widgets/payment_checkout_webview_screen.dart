import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum PaymentCheckoutCloseReason {
  completed,
  userCancelled,
}

class PaymentCheckoutWebViewScreen extends StatefulWidget {
  final String checkoutUrl;
  final String paymentId;
  final String paymentReturnDeepLinkBase;
  final String? backLink;
  final String? failureBackLink;

  const PaymentCheckoutWebViewScreen({
    super.key,
    required this.checkoutUrl,
    required this.paymentId,
    required this.paymentReturnDeepLinkBase,
    this.backLink,
    this.failureBackLink,
  });

  static Future<PaymentCheckoutCloseReason> open(
    BuildContext context, {
    required String checkoutUrl,
    required String paymentId,
    required String paymentReturnDeepLinkBase,
    String? backLink,
    String? failureBackLink,
  }) async {
    final result = await Navigator.of(context).push<PaymentCheckoutCloseReason>(
      MaterialPageRoute(
        builder: (_) => PaymentCheckoutWebViewScreen(
          checkoutUrl: checkoutUrl,
          paymentId: paymentId,
          paymentReturnDeepLinkBase: paymentReturnDeepLinkBase,
          backLink: backLink,
          failureBackLink: failureBackLink,
        ),
      ),
    );

    return result ?? PaymentCheckoutCloseReason.userCancelled;
  }

  @override
  State<PaymentCheckoutWebViewScreen> createState() =>
      _PaymentCheckoutWebViewScreenState();
}

class _PaymentCheckoutWebViewScreenState
    extends State<PaymentCheckoutWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          },
          onPageFinished: (_) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onNavigationRequest: _onNavigationRequest,
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  NavigationDecision _onNavigationRequest(NavigationRequest request) {
    final uri = Uri.tryParse(request.url);
    if (uri == null) {
      return NavigationDecision.navigate;
    }

    final normalizedReturnBase = widget.paymentReturnDeepLinkBase.toLowerCase();
    final normalizedUrl = request.url.toLowerCase();

    if (normalizedUrl.startsWith(normalizedReturnBase)) {
      _close(PaymentCheckoutCloseReason.completed);
      return NavigationDecision.prevent;
    }

    if (_matchesCallbackUrl(uri, widget.backLink) ||
        _matchesCallbackUrl(uri, widget.failureBackLink)) {
      _close(PaymentCheckoutCloseReason.completed);
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  bool _matchesCallbackUrl(Uri currentUri, String? callbackUrl) {
    if (callbackUrl == null || callbackUrl.isEmpty) {
      return false;
    }

    final callbackUri = Uri.tryParse(callbackUrl);
    if (callbackUri == null) {
      return false;
    }

    return currentUri.scheme == callbackUri.scheme &&
        currentUri.host == callbackUri.host &&
        currentUri.path == callbackUri.path;
  }

  void _close(PaymentCheckoutCloseReason reason) {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop(reason);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _close(PaymentCheckoutCloseReason.userCancelled),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
