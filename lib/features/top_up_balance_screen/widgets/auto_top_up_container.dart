import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/features/top_up_balance_screen/bloc/top_up_balance_bloc.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutoTopUpContainer extends StatelessWidget {
  const AutoTopUpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpBalanceBloc, TopUpBalanceState>(
      builder: (context, state) {
        final enabled = state.autoTopUpEnabled;

        return GestureDetector(
          onTap: () {
            context.read<TopUpBalanceBloc>().add(ToggleAutoTopUp(!enabled));
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: enabled
                    ? [
                        const Color(0xFFE7F8F5),
                        const Color(0xFFD9F2ED),
                      ]
                    : [
                        AppColors.containerGray.withValues(alpha: 0.8),
                        AppColors.containerGray.withValues(alpha: 0.6),
                      ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: enabled
                    ? const Color(0xFF15BAAA).withValues(alpha: 0.3)
                    : Colors.grey.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.flash_on,
                    color: Colors.orange.shade600,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocalizedText(
                        SimLocalizations.of(context)!.auto_top_up,
                        style: FlexTypography.paragraph.medium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      LocalizedText(
                        SimLocalizations.of(context)!.auto_top_up_description,
                        style: FlexTypography.paragraph.small.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: enabled,
                  activeColor: const Color(0xFF15BAAA),
                  onChanged: (value) {
                    context
                        .read<TopUpBalanceBloc>()
                        .add(ToggleAutoTopUp(value));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
