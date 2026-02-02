import 'package:vink_sim/core/platform_device/platform_detector.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/core/styles/flex_typography.dart';
import 'package:vink_sim/features/esim_management/widgets/setup/body_container.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:vink_sim/services/esim_service.dart';
import 'package:vink_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class FastSelectedBody extends StatelessWidget {
  final String? smdpServer;
  final String? activationCode;
  final String? fullActivationString;
  final bool isLoading;
  final String? errorMessage;

  const FastSelectedBody({
    super.key,
    this.smdpServer,
    this.activationCode,
    this.fullActivationString,
    this.isLoading = false,
    this.errorMessage,
  });

  Future<void> _installEsim() async {
    final String activationString = fullActivationString ??
        (smdpServer != null && activationCode != null
            ? "LPA:1\$$smdpServer\$$activationCode"
            : "");
    if (activationString.isEmpty) {
      return;
    }

    try {
      Uri? esimUrl;

      if (PlatformDetector.isIos) {
        esimUrl = Uri.parse(
          'https://esimsetup.apple.com/esim_qrcode_provisioning?carddata=$activationString',
        );
      } else if (PlatformDetector.isAndroid) {
        esimUrl = Uri.parse(
          'https://esimsetup.android.com/esim_qrcode_provisioning?carddata=$activationString',
        );
      }

      if (esimUrl != null) {
        if (await canLaunchUrl(esimUrl)) {
          final launched = await launchUrl(
            esimUrl,
            mode: LaunchMode.externalApplication,
          );
          if (launched) {
            debugPrint('Successfully launched eSIM setup: $esimUrl');
            return;
          }
        }
      }

      // Output debug info if launch failed or not supported
      debugPrint(
        'Could not launch eSIM setup URL or platform not supported for link.',
      );

      // Fallback or legacy handling if needed, but per requirements we strictly use links.
    } catch (e) {
      debugPrint('Error installing eSIM profile: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String currentLanguange =
        Localizations.localeOf(context).languageCode;

    final defaultNumber = currentLanguange == 'en'
        ? Assets.icons.figma112.defaultNumberEng
        : Assets.icons.figma112.defaultNumber;
    final facetimeImessage = currentLanguange == 'en'
        ? Assets.icons.figma112.facetimeImessageEng
        : Assets.icons.figma112.facetimeImessage;
    final chooseMobileData = currentLanguange == 'en'
        ? Assets.icons.figma112.chooseMobileDataEng
        : Assets.icons.figma112.chooseMobileData;
    final dataRouming = currentLanguange == 'en'
        ? Assets.icons.figma112.dataRoumingEng
        : Assets.icons.figma112.dataRouming;
    final importantStepTodo = currentLanguange == 'en'
        ? Assets.icons.figma112.importantStepTodoEng
        : Assets.icons.figma112.importantStepTodo;

    return Column(
      children: [
        BodyContainer(
          args: ['1'],
          description: SimLocalizations.of(context)!.fast_description_step1,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: GestureDetector(
              onTap: isLoading
                  ? null
                  : () async {
                      debugPrint('Button tapped! isLoading: $isLoading');
                      debugPrint(
                        'smdpServer: $smdpServer, activationCode: $activationCode',
                      );

                      if (smdpServer == null || activationCode == null) {
                        debugPrint(
                          'Missing required data - smdpServer or activationCode is null',
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Missing eSIM configuration data',
                              ),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                        return;
                      }

                      try {
                        if (PlatformDetector.isIos) {
                          debugPrint('iOS detected - launching eSIM setup');
                          await _installEsim();
                        } else if (PlatformDetector.isAndroid) {
                          debugPrint(
                            'Android detected - requesting storage permission',
                          );
                          final permission = await Permission.storage.request();
                          if (permission.isGranted) {
                            await _installEsim();
                          } else {
                            debugPrint(
                              'Storage permission denied for Android eSIM setup',
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Storage permission is required for eSIM setup',
                                  ),
                                ),
                              );
                            }
                          }
                        } else if (PlatformDetector.isWeb) {
                          debugPrint(
                              'Web detected - eSIM setup via link not fully supported');
                        }
                      } catch (e) {
                        debugPrint('Error during eSIM setup: $e');
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to setup eSIM: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
              child: Container(
                alignment: Alignment.center,
                height: 52,
                decoration: BoxDecoration(
                  gradient: isLoading
                      ? LinearGradient(colors: [Colors.grey, Colors.grey])
                      : AppColors.containerGradientPrimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      )
                    : LocalizedText(
                        SimLocalizations.of(context)!.download,
                        style: FlexTypography.label.medium.copyWith(
                          color: AppColors.textColorLight,
                        ),
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        BodyContainer(
          args: ['2'],
          description: SimLocalizations.of(context)!.fast_description_step2,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: defaultNumber.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: facetimeImessage.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        BodyContainer(
          args: ['3'],
          description: SimLocalizations.of(context)!.fast_description_step3,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: chooseMobileData.image(
                  width: 313,
                  height: 292,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        BodyContainer(
          args: ['4'],
          description: SimLocalizations.of(context)!.fast_description_step4,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: dataRouming.image(
                  width: 274.8,
                  height: 291,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        BodyContainer(
          stepTitle: SimLocalizations.of(context)!.important,
          description: SimLocalizations.of(
            context,
          )!
              .another_device_description_important,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: importantStepTodo.image(
                  width: 313,
                  height: 240,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
