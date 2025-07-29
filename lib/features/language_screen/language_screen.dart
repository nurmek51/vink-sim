import 'package:easy_localization/easy_localization.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String get currentLanguage => context.locale.languageCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.language.tr(), 
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
      body: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 16.0,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            LanguageButton(
              icon: Assets.icons.englandFlag.path,
              language: AppLocalizations.appLanguageEn.tr(),
              isSelected: currentLanguage == 'en',
              onTap: () => _changeLanguage('en'),
            ),
            const SizedBox(height: 12),
            LanguageButton(
              icon: Assets.icons.russianFlag.path,
              language: AppLocalizations.russian.tr(),
              isSelected: currentLanguage == 'ru',
              onTap: () => _changeLanguage('ru'),
            ),              
          ],
        ),
      ),
    );
  }

  void _changeLanguage(String languageCode) async {
    await context.setLocale(Locale(languageCode));
    setState(() {});
  }
}

class LanguageButton extends StatelessWidget {
  final String icon;
  final String language;
  final bool isSelected;
  final VoidCallback onTap;
  const LanguageButton({
    super.key,
    required this.icon,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,        
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
                        style: FlexTypography.paragraph.large.copyWith(
                          color: isSelected ? Colors.blue : Colors.black,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      if (isSelected)
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.blue,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.black26),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
