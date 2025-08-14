import 'package:easy_localization/easy_localization.dart';
import 'package:flex_travel_sim/core/models/imsi_model.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/shared/widgets/blue_gradient_button.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';

class SimCardSelectionModal extends StatelessWidget {
  final List<ImsiModel> simCards;
  final String? selectedImsi;
  final Function(ImsiModel) onSimCardSelected;

  const SimCardSelectionModal({
    super.key,
    required this.simCards,
    this.selectedImsi,
    required this.onSimCardSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const LocalizedText(
                  AppLocalizations.selectSimCard,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: simCards.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final simCard = simCards[index];
                final isSelected = simCard.imsi == selectedImsi;

                return GestureDetector(
                  onTap: () {
                    onSimCardSelected(simCard);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          isSelected
                              ? Border.all(
                                color: const Color(0xFF15BAAA),
                                width: 2,
                              )
                              : Border.all(color: Colors.grey[200]!, width: 2),
                    ),
                    child: Row(
                      children: [
                        isSelected
                            ? Assets.icons.checkbox.svg()
                            : Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey[400]!,
                                  width: 2,
                                ),
                              ),
                            ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                simCard.country ??
                                    '${AppLocalizations.simCardFallback.tr()} ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${simCard.balance.toStringAsFixed(0)}\$',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const LocalizedText(
                              AppLocalizations.onBalance,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlueGradientButton(
              title: AppLocalizations.selectForTopUp.tr(),
              onTap: () {
                final selectedSimCard = simCards.firstWhere(
                  (simCard) => simCard.imsi == selectedImsi,
                  orElse: () => simCards.first,
                );
                onSimCardSelected(selectedSimCard);
                Navigator.of(context).pop();
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
