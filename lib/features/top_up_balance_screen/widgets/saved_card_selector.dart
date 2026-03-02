import 'package:flutter/material.dart';
import 'package:vink_sim/features/payment/domain/repositories/payment_repository.dart';
import 'package:vink_sim/gen/assets.gen.dart';

class SavedCardSelector extends StatelessWidget {
  final SavedCard? selectedCard;
  final VoidCallback onTap;

  const SavedCardSelector({
    super.key,
    required this.selectedCard,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardMask = selectedCard?.cardMask ?? '**** **** **** ****';
    final cardType = selectedCard?.cardType ?? 'Card';

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
              child: Assets.icons.credCard.svg(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$cardType • $cardMask',
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
