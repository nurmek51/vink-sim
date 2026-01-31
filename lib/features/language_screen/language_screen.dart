import 'package:vink_sim/core/utils/asset_utils.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/config/feature_config.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String get currentLanguage => Localizations.localeOf(context).languageCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          SimLocalizations.of(context)!.language,
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
        padding: const EdgeInsets.only(top: 15, left: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            LanguageButton(
              icon: Assets.icons.usaFlag.path,
              language: SimLocalizations.of(context)!.app_language_en,
              isSelected: currentLanguage == 'en',
              onTap: () => _changeLanguage('en'),
            ),
            const SizedBox(height: 12),
            LanguageButton(
              icon: Assets.icons.russianFlag.path,
              language: SimLocalizations.of(context)!.russian,
              isSelected: currentLanguage == 'ru',
              onTap: () => _changeLanguage('ru'),
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(String languageCode) async {
    debugPrint('Language change requested: $languageCode');
    if (sl.isRegistered<FeatureConfig>()) {
      final config = sl<FeatureConfig>();
      config.onLocaleChanged?.call(Locale(languageCode));
    } else {
      debugPrint('FeatureConfig not registered');
    }
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
            SvgPicture.asset(
              icon,
              package: AssetUtils.package,
              width: 32,
              height: 32,
            ),
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
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      if (isSelected)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: const Icon(Icons.check, color: Colors.blue),
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
