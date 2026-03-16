import 'package:flutter/material.dart';
import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:vink_sim/features/payment/domain/repositories/payment_repository.dart';
import 'package:vink_sim/gen/assets.gen.dart';

class SavedCardSelector extends StatelessWidget {
  final SavedCard? selectedCard;
  final bool isLoading;
  final VoidCallback onTap;

  const SavedCardSelector({
    super.key,
    required this.selectedCard,
    this.isLoading = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selectedText = selectedCard == null
        ? 'Choose from saved card'
        : '${selectedCard!.cardType ?? 'Card'} • ${selectedCard!.cardMask}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFE7EFF7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
              child: Assets.icons.credCard.svg(package: AssetUtils.package),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: isLoading
                  ? const SizedBox(
                      height: 18,
                      child: LinearProgressIndicator(
                        minHeight: 2,
                        backgroundColor: Color(0xFFD9E2EC),
                        color: Color(0xFF15BAAA),
                      ),
                    )
                  : Text(
                      selectedText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 24,
              color: const Color(0xFF363C45).withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}
