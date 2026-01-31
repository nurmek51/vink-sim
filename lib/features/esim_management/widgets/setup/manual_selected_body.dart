import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/features/esim_management/widgets/setup/body_container.dart';
import 'package:vink_sim/gen/assets.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ManualSelectedBody extends StatelessWidget {
  final String? smdpServer;
  final String? activationCode;
  final bool isLoading;
  final String? errorMessage;

  const ManualSelectedBody({
    super.key,
    this.smdpServer,
    this.activationCode,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    String resolveText(String? value) {
      if (isLoading) {
        return SimLocalizations.of(context)!.loading;
      }
      if (errorMessage != null && errorMessage!.isNotEmpty) {
        return errorMessage!;
      }
      if (value != null && value.isNotEmpty) {
        return value;
      }
      return SimLocalizations.of(context)!.not_available;
    }

    final smdpServerText = resolveText(smdpServer);
    final activationCodeText = resolveText(activationCode);

    if (kDebugMode) {
      print('smdpServer: $smdpServer - activationCode: $activationCode');
    }

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
    final scanQr =
        currentLanguange == 'en'
            ? Assets.icons.figma112.scanQrEng
            : Assets.icons.figma112.scanQr;
    final enterActivationCode =
        currentLanguange == 'en'
            ? Assets.icons.figma112.activationCodeEng
            : Assets.icons.figma112.activationCode;

    return Column(
      children: [
        BodyContainer(
          args: ['1'],
          description: SimLocalizations.of(context)!.manual_description1,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.textColorLight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HelveticaneueFont(
                            text: SimLocalizations.of(context)!.adress_sm_dp,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 3),
                          HelveticaneueFont(
                            text: smdpServerText,
                            fontSize: 16,
                            color: AppColors.textColorDark,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 7),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.textColorLight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HelveticaneueFont(
                            text: SimLocalizations.of(context)!.activation_code,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 3),
                          HelveticaneueFont(
                            text: activationCodeText,
                            fontSize: 16,
                            color: AppColors.textColorDark,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                        const SizedBox(width: 10),
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
                          child: scanQr.image(
                            width: 271.59,
                            height: 287.61,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: enterActivationCode.image(
                            width: 271.59,
                            height: 287.61,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        BodyContainer(
          args: ['2'],
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
          args: ['3'],
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
          args: ['4'],
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
          args: ['5'],
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
