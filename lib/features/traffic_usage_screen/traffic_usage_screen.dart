import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';

class TrafficUsageScreen extends StatelessWidget {
  const TrafficUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 20);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: LocalizedText(
          SimLocalizations.of(context)!.traffic_usage,
          style: FlexTypography.headline.small.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: horizontalPadding,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                height: 61,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Text(
                      '147.5 GB',
                      style: FlexTypography.label.medium.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    LocalizedText(
                      SimLocalizations.of(context)!.april_2023,
                      style: FlexTypography.label.medium.copyWith(
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
