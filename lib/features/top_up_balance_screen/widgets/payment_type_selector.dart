import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentTypeSelector extends StatefulWidget {
  const PaymentTypeSelector({super.key});

  @override
  State<PaymentTypeSelector> createState() => _PaymentTypeSelectorState();
}

class _PaymentTypeSelectorState extends State<PaymentTypeSelector> {
  int selectedIndex = 0;

  final List<String> logos = [
    'assets/icons/apple_pay_logo.svg',
    'assets/icons/crypto.svg',
    'assets/icons/cred_card.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(logos.length, (index) {
        return PaymentTypeWidget(
          logo: logos[index],
          isSelected: selectedIndex == index,
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
        );
      }),
    );
  }
}

class PaymentTypeWidget extends StatelessWidget {
  final String logo;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentTypeWidget({
    super.key,
    required this.logo,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              alignment: Alignment.center,
              height: 66,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFFD4D4D4), width: 1),
              ),
              child: SvgPicture.asset(
                logo,
                color: isSelected ? Colors.white : Colors.black45,
              ),
            ),
            if (isSelected)
              Positioned(
                top: -6,
                right: -6,
                child: SvgPicture.asset('assets/icons/selected_card_icon.svg'),
              ),
          ],
        ),
      ),
    );
  }
}
