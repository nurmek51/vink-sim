import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/features/esim_management/widgets/build_qr_code.dart';
import 'package:vink_sim/features/esim_management/widgets/setup/body_container.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class AnotherDeviceSelectedBody extends StatelessWidget {
  final String? qrCode;
  final bool isLoading;
  final String? errorMessage;

  const AnotherDeviceSelectedBody({
    super.key,
    this.qrCode,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final String currentLanguange =
        Localizations.localeOf(context).languageCode;

    final mobileCommunication =
        currentLanguange == 'en'
            ? Assets.icons.figma112.mobileCommunicationEng
            : Assets.icons.figma112.mobileCommunication;
    final addEsim =
        currentLanguange == 'en'
            ? Assets.icons.figma112.addEsimEng
            : Assets.icons.figma112.addEsim;
    final settingsByQr =
        currentLanguange == 'en'
            ? Assets.icons.figma112.settingsByQrEng
            : Assets.icons.figma112.settingsByQr;
    final qrMobileTariff =
        currentLanguange == 'en'
            ? Assets.icons.figma112.qrMobileTariffEng
            : Assets.icons.figma112.qrMobileTariff;
    final forTravels =
        currentLanguange == 'en'
            ? Assets.icons.figma112.forTravelsEng
            : Assets.icons.figma112.forTravels;
    final flexPlan =
        currentLanguange == 'en'
            ? Assets.icons.figma112.flexPlanEng
            : Assets.icons.figma112.flexPlan;
    final defaultNumber =
        currentLanguange == 'en'
            ? Assets.icons.figma112.defaultNumberEng
            : Assets.icons.figma112.defaultNumber;
    final facetimeImessage =
        currentLanguange == 'en'
            ? Assets.icons.figma112.facetimeImessageEng
            : Assets.icons.figma112.facetimeImessage;
    final chooseMobileData =
        currentLanguange == 'en'
            ? Assets.icons.figma112.chooseMobileDataEng
            : Assets.icons.figma112.chooseMobileData;
    final dataRouming =
        currentLanguange == 'en'
            ? Assets.icons.figma112.dataRoumingEng
            : Assets.icons.figma112.dataRouming;
    final importantStepTodo =
        currentLanguange == 'en'
            ? Assets.icons.figma112.importantStepTodoEng
            : Assets.icons.figma112.importantStepTodo;

    return Column(
      children: [
        Container(
          height: 251,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFE7EFF7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 52,
                  width: 45,
                  child: Assets.icons.attentionCircle.svg(),
                ),
                SizedBox(height: 10),
                HelveticaneueFont(
                  text: SimLocalizations.of(context)!.attention,
                  fontSize: 18,
                  color: AppColors.textColorDark,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                HelveticaneueFont(
                  text:
                      SimLocalizations.of(
                        context,
                      )!.another_device_description_warning,
                  fontSize: 16,
                  color: AppColors.textColorDark,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 15),

        BodyContainer(
          args: ['1'],
          description:
              SimLocalizations.of(context)!.another_device_description1,
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
          args: ['2'],
          description:
              SimLocalizations.of(context)!.another_device_description2,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
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
                    qrCode: qrCode,
                    isLoading: isLoading,
                    errorMessage: errorMessage,
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        BodyContainer(
          args: ['3'],
          description:
              SimLocalizations.of(context)!.another_device_description3,
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
          description:
              SimLocalizations.of(context)!.another_device_description5,
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

        SizedBox(height: 15),

        BodyContainer(
          args: ['6'],
          description: SimLocalizations.of(context)!.fast_description_step4,
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
          stepTitle: SimLocalizations.of(context)!.important,
          description:
              SimLocalizations.of(
                context,
              )!.another_device_description_important,
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
