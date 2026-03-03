import 'package:flutter/material.dart';
import 'package:vink_sim/features/payment/domain/repositories/payment_repository.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/shared/widgets/blue_gradient_button.dart';

class SavedCardSelectionModal extends StatefulWidget {
  final List<SavedCard> savedCards;
  final String? selectedCardId;
  final ValueChanged<SavedCard?> onCardSelected;

  const SavedCardSelectionModal({
    super.key,
    required this.savedCards,
    this.selectedCardId,
    required this.onCardSelected,
  });

  @override
  State<SavedCardSelectionModal> createState() =>
      _SavedCardSelectionModalState();
}

class _SavedCardSelectionModalState extends State<SavedCardSelectionModal> {
  late String? _selectedCardId;

  @override
  void initState() {
    super.initState();
    _selectedCardId = widget.selectedCardId ??
        (widget.savedCards.isNotEmpty ? widget.savedCards.first.id : null);
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
                const Text(
                  'Select card',
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
              itemCount: widget.savedCards.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == 0) {
                  final isSelected = _selectedCardId == null;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCardId = null;
                      });
                      widget.onCardSelected(null);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF15BAAA)
                              : Colors.grey[200]!,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.add_card_rounded, color: Colors.black),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Other card',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          if (isSelected) Assets.icons.selectedCardIcon.svg(),
                        ],
                      ),
                    ),
                  );
                }

                final card = widget.savedCards[index - 1];
                final isSelected = card.id == _selectedCardId;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCardId = card.id;
                    });
                    widget.onCardSelected(card);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF15BAAA)
                            : Colors.grey[200]!,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                          child: Assets.icons.credCard.svg(),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card.cardMask,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              if ((card.cardType ?? '').isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  card.cardType!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (isSelected) Assets.icons.selectedCardIcon.svg(),
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
              title: 'Use selected card',
              onTap: () {
                SavedCard? selectedCard;
                if (_selectedCardId != null) {
                  for (final card in widget.savedCards) {
                    if (card.id == _selectedCardId) {
                      selectedCard = card;
                      break;
                    }
                  }
                }
                widget.onCardSelected(selectedCard);
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
