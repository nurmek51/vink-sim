import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:vink_sim/constants/app_colors.dart';
import 'package:vink_sim/core/layout/screen_utils.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/features/guide_page/components/widgets/table_view_cells.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_state.dart';
import 'package:vink_sim/shared/widgets/blue_gradient_button.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuidePage extends StatelessWidget {
  final bool isAuthorized;
  const GuidePage({super.key, this.isAuthorized = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ).copyWith(bottom: 30, top: 12),
        child: BlueGradientButton(
          onTap: () => NavigationService.openTopUpBalanceScreen(context),
          title: SimLocalizations.of(context)!.top_up_balance,
        ),
      ),
      backgroundColor: AppColors.backgroundColorLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColorLight,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: BlocBuilder<SubscriberBloc, SubscriberState>(
        builder: (context, state) {
          final hasEsims =
              state is SubscriberLoaded && state.subscriber.imsiList.isNotEmpty;

          return Padding(
            padding: EdgeInsets.only(
              top: isSmallScreen(context) ? 0 : 10,
              bottom: 50,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HelveticaneueFont(
                  text: SimLocalizations.of(context)!.how_does_it_work,
                  fontSize: 28,
                  letterSpacing: -1,
                  height: 1.1,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF363C45),
                ),
                SizedBox(height: 15),
                HelveticaneueFont(
                  text: SimLocalizations.of(context)!.esim_description1,
                  fontSize: 17,
                  letterSpacing: -0.5,
                  height: 1.3,
                  color: Color(0xFF363C45),
                ),
                SizedBox(height: 12),
                HelveticaneueFont(
                  text: SimLocalizations.of(context)!.esim_description2,
                  fontSize: 17,
                  letterSpacing: -0.5,
                  height: 1.3,
                  color: Color(0xFF363C45),
                ),
                SizedBox(height: isSmallScreen(context) ? 3 : 12),
                TableViewCells(isAuthorized: isAuthorized, hasEsims: hasEsims),
              ],
            ),
          );
        },
      ),
    );
  }
}
