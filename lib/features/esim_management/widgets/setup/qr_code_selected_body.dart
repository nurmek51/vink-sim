import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/app_colors.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/build_qr_code.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/share_qr/qr_service.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/body_container.dart';
import 'package:flex_travel_sim/gen/assets.gen.dart';
import 'package:flex_travel_sim/shared/widgets/localized_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QrCodeSelectedBody extends StatefulWidget {
  final String? qrCode;
  final bool isLoading;
  final String? errorMessage;

  const QrCodeSelectedBody({
    super.key,
    this.qrCode,
    this.isLoading = false,
    this.errorMessage,
  });

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
    if (kDebugMode) {
      print('QR Code: ${widget.qrCode}');
    }

    final String currentLanguange = context.locale.languageCode;
    
    final mobileCommunication = currentLanguange == 'en'
        ? Assets.icons.figma112.mobileCommunicationEng
        : Assets.icons.figma112.mobileCommunication;    
    final addEsim = currentLanguange == 'en'
        ? Assets.icons.figma112.addEsimEng
        : Assets.icons.figma112.addEsim;  
    final settingsByQr = currentLanguange == 'en'
        ? Assets.icons.figma112.settingsByQrEng
        : Assets.icons.figma112.settingsByQr; 
    final qrMobileTariff = currentLanguange == 'en'
        ? Assets.icons.figma112.qrMobileTariffEng
        : Assets.icons.figma112.qrMobileTariff;    
    final forTravels = currentLanguange == 'en'
        ? Assets.icons.figma112.forTravelsEng
        : Assets.icons.figma112.forTravels;  
    final flexPlan = currentLanguange == 'en'
        ? Assets.icons.figma112.flexPlanEng
        : Assets.icons.figma112.flexPlan; 
    final defaultNumber = currentLanguange == 'en'
        ? Assets.icons.figma112.defaultNumberEng
        : Assets.icons.figma112.defaultNumber; 
    final dataRouming = currentLanguange == 'en'
        ? Assets.icons.figma112.dataRoumingEng
        : Assets.icons.figma112.dataRouming;    
    final importantStepTodo = currentLanguange == 'en'
        ? Assets.icons.figma112.importantStepTodoEng
        : Assets.icons.figma112.importantStepTodo;
    final facetimeImessage = currentLanguange == 'en'
        ? Assets.icons.figma112.facetimeImessageEng
        : Assets.icons.figma112.facetimeImessage;             

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
                              height: 228,
                              width: 228,
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColorLight,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 210,
                                  width: 210,
                                  child: BuildQrCode(
                                    qrCode: widget.qrCode,
                                    isLoading: widget.isLoading,
                                    errorMessage: widget.errorMessage,
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
                    onTap: () async {
                      if (_isQrVisible && widget.qrCode != null) {
                        await QrShareService.shareWidget(
                          qrKey,
                          text: 'eSIM QR',
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
                      child: mobileCommunication.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: addEsim.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: settingsByQr.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: qrMobileTariff.image(
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
                      child: forTravels.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: flexPlan.image(
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
                      child: defaultNumber.image(
                        width: 271.59,
                        height: 287.61,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(width: 10),
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

        SizedBox(height: 15),

        BodyContainer(
          args: ['5'],
          description: AppLocalizations.anotherDeviceDescription5,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: mobileCommunication.image(
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
                child: dataRouming.image(
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
