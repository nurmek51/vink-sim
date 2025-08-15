import 'dart:ui';

import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/share_qr/qr_service.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/body_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeSelectedBody extends StatefulWidget {
  const QrCodeSelectedBody({super.key});

  @override
  State<QrCodeSelectedBody> createState() => _QrCodeSelectedBodyState();
}

class _QrCodeSelectedBodyState extends State<QrCodeSelectedBody> {
  final GlobalKey qrKey = GlobalKey();
  bool _isQrVisible = false;

  void _toggleQrVisibility() {
    if (!_isQrVisible) {
      setState(() {
        _isQrVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BodyContainer(
          args: ['1'],
          description: AppLocalizations.qrCodeDescription,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          RepaintBoundary(
                            key: qrKey,
                            child: Container(
                              height: 240,
                              width: 240,
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColorLight,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 210,
                                  width: 210,
                                  child: QrImageView(
                                    data: 'LPA:1\$smdp.io\$K2-2DJM5S-18WUF79',
                                    version: QrVersions.auto,
                                    errorStateBuilder: (cxt, err) {
                                      return Center(
                                        child: Text(
                                          'Uh oh! Something went wrong...',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: AnimatedOpacity(
                              opacity: _isQrVisible ? 0.0 : 1.0,
                              duration: const Duration(milliseconds: 500),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                child: Container(
                                  color: const Color.fromRGBO(
                                    255,
                                    255,
                                    255,
                                    0.8,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 7,
                                          ),
                                          child: SizedBox(
                                            height: 43,
                                            width: 43,
                                            child: Assets.icons.infoQrCircle
                                                .svg(height: 43, width: 43),
                                          ),
                                        ),

                                        HelveticaneueFont(
                                          text: AppLocalizations.attention,
                                          fontSize: 16,
                                          color: AppColors.textColorDark,
                                          fontWeight: FontWeight.bold,
                                        ),

                                        const SizedBox(height: 7),

                                        HelveticaneueFont(
                                          text:
                                              AppLocalizations
                                                  .youCanActivateEsimOnlyOnce,
                                          fontSize: 16,
                                          color: AppColors.textColorDark,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    // onTap: _toggleQrVisibility,
                    onTap: () async {
                      if (_isQrVisible) {
                        // шарим QR
                        await QrShareService.shareWidget(
                          qrKey,
                          text: 'Мой QR',
                        );
                      } else {
                        _toggleQrVisibility();
                      }
                    },                    
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient:
                            _isQrVisible
                                ? AppColors.containerGradientPrimary
                                : null,
                        color: !_isQrVisible ? AppColors.grayBlue : null,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: LocalizedText(
                        _isQrVisible
                            ? AppLocalizations.sendQr
                            : AppLocalizations.showQr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //сюда
        SizedBox(height: 15),

        BodyContainer(
          args: ['2'],
          description: AppLocalizations.anotherDeviceDescription1,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Assets.icons.figma112.mobileCommunication.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Assets.icons.figma112.addEsim.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Assets.icons.figma112.settingsByQr.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Assets.icons.figma112.qrMobileTariff.image(
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

        SizedBox(height: 15),

        BodyContainer(
          args: ['3'],
          description: AppLocalizations.anotherDeviceDescription3,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Assets.icons.figma112.forTravels.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Assets.icons.figma112.flexPlan.image(
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

        SizedBox(height: 15),

        BodyContainer(
          args: ['4'],
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
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Assets.icons.figma112.
                      facetimeImessage.image(
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

        SizedBox(height: 15),

        BodyContainer(
          args: ['5'],
          description: AppLocalizations.anotherDeviceDescription5,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Assets.icons.figma112.mobileCommunication.image(
                  width: 313,
                  height: 292,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        BodyContainer(
          args: ['6'],
          description: AppLocalizations.fastDescriptionStep4,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Assets.icons.figma112.dataRouming.image(
                  width: 313,
                  height: 292,
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
