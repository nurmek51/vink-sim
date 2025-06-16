import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Language', 
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
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              LanguageButton(
                icon: Assets.icons.russianFlag.path,
                language: 'Русский',
              ),
              const SizedBox(height: 12),
              LanguageButton(
                icon: Assets.icons.chinaFlag.path,
                language: 'Китайский',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String icon;
  final String language;
  const LanguageButton({super.key, required this.icon, required this.language});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      language, 
                      style: FlexTypography.headline.xMedium,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.black26),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
