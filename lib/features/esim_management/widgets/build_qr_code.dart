import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vink_sim/l10n/app_localizations.dart';

class BuildQrCode extends StatelessWidget {
  final String? qrCode;
  final bool isLoading;
  final String? errorMessage;

  const BuildQrCode({
    super.key,
    this.qrCode,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: LocalizedText(errorMessage!));
    }

    if (qrCode == null || qrCode!.isEmpty) {
      return Center(
        child: LocalizedText(SimLocalizations.of(context)!.not_available),
      );
    }

    return QrImageView(
      data: qrCode!,
      version: QrVersions.auto,
      errorStateBuilder: (cxt, err) {
        return const Center(
          child: Text(
            'Uh oh! Something went wrong...',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
