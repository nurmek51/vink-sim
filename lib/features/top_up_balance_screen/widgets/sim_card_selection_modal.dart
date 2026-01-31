import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/models/imsi_model.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/shared/widgets/blue_gradient_button.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';

class SimCardSelectionModal extends StatefulWidget {
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
  State<SimCardSelectionModal> createState() => _SimCardSelectionModalState();
}

class _SimCardSelectionModalState extends State<SimCardSelectionModal> {
  late String? selectedImsi;

  @override
  void initState() {
    super.initState();
    selectedImsi = widget.selectedImsi;
  }

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
                Text(
                  SimLocalizations.of(context)!.select_sim_card,
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
              itemCount: widget.simCards.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final simCard = widget.simCards[index];
                final isSelected = simCard.imsi == selectedImsi;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImsi = simCard.imsi;
                    });
                    widget.onSimCardSelected(simCard);
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
                                    '${SimLocalizations.of(context)!.sim_card_fallback} ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                simCard.iccid != null &&
                                        simCard.iccid!.length > 4
                                    ? '**** ${simCard.iccid!.substring(simCard.iccid!.length - 4)}'
                                    : '****',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
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
                            LocalizedText(
                              SimLocalizations.of(context)!.on_balance,
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
              title: SimLocalizations.of(context)!.select_for_top_up,
              onTap: () {
                final selectedSimCard = widget.simCards.firstWhere(
                  (simCard) => simCard.imsi == selectedImsi,
                  orElse: () => widget.simCards.first,
                );
                widget.onSimCardSelected(selectedSimCard);
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
