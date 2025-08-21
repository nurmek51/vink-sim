import 'dart:io';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/styles/flex_typography.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/body_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/services/esim_service.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class FastSelectedBody extends StatelessWidget {
  final String? smdpServer;
  final String? activationCode;
  final bool isLoading;
  final String? errorMessage;

  const FastSelectedBody({
    super.key,
    this.smdpServer,
    this.activationCode,
    this.isLoading = false,
    this.errorMessage,
  });

  Future<void> _installEsim() async {
    if (smdpServer == null || activationCode == null) {
      return;
    }

    try {
      if (Platform.isIOS) {
        // Use Apple's native eSIM URL scheme for iOS 17.5+
        final lpaData = '$smdpServer:$activationCode';
        final esimUrl = Uri.parse(
          'https://esimsetup.apple.com/esim_qrcode_provisioning?carddata=LPA:$lpaData',
        );

        if (await canLaunchUrl(esimUrl)) {
          final launched = await launchUrl(
            esimUrl,
            mode: LaunchMode.externalApplication,
          );

          if (launched) {
            debugPrint(
              'Successfully launched iOS eSIM setup with LPA: $lpaData',
            );
          } else {
            debugPrint('Failed to launch iOS eSIM setup URL');
            throw Exception('Could not open iOS eSIM setup');
          }
        } else {
          debugPrint('Cannot launch iOS eSIM setup URL');
          throw Exception('iOS eSIM setup URL not supported on this device');
        }
      } else {
        // Fallback to existing service for Android
        final result = await EsimService.installEsimProfile(
          smdpServer: smdpServer!,
          activationCode: activationCode!,
        );
        debugPrint('eSIM installation result: $result');
      }
    } catch (e) {
      debugPrint('Error installing eSIM profile: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BodyContainer(
          args: ['1'],
          description: AppLocalizations.fastDescriptionStep1,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: GestureDetector(
              onTap:
                  isLoading
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
                          if (Platform.isIOS) {
                            debugPrint('iOS detected - launching eSIM setup');
                            await _installEsim();
                          } else {
                            debugPrint(
                              'Android detected - requesting storage permission',
                            );
                            final permission =
                                await Permission.storage.request();
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
                  gradient:
                      isLoading
                          ? LinearGradient(colors: [Colors.grey, Colors.grey])
                          : AppColors.containerGradientPrimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child:
                    isLoading
                        ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        )
                        : LocalizedText(
                          AppLocalizations.download,
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
          description: AppLocalizations.fastDescriptionStep2,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Assets.icons.figma112.defaultNumber.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Assets.icons.figma112.facetimeImessage.image(
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
          description: AppLocalizations.fastDescriptionStep3,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Assets.icons.figma112.chooseMobileData.image(
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
          description: AppLocalizations.fastDescriptionStep4,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Assets.icons.figma112.dataRouming.image(
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
          stepTitle: AppLocalizations.important,
          description: AppLocalizations.anotherDeviceDescriptionImportant,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Assets.icons.figma112.importantStepTodo.image(
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
