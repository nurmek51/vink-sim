import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flex_travel_sim/core/layout/screen_utils.dart';
import 'package:flex_travel_sim/core/localization/app_localizations.dart';
import 'package:flex_travel_sim/core/platform_device/platform_detector.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flex_travel_sim/features/esim_management/bloc/esim_setup_bloc.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/another_device_selected_body.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/bottom_setup_container.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/lazy_row.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/fast_selected_body.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/manual_selected_body.dart';
import 'package:flex_travel_sim/features/esim_management/widgets/setup/qr_code_selected_body.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_event.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_state.dart';
import 'package:flex_travel_sim/utils/navigation_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EsimSetupPage extends StatefulWidget {
  const EsimSetupPage({super.key});

  @override
  State<EsimSetupPage> createState() => _EsimSetupPageState();
}

class _EsimSetupPageState extends State<EsimSetupPage> {
  List<String> getRowOptions() {
    if (PlatformDetector.isIos) {
      return [
        AppLocalizations.fastSelectedRow,
        AppLocalizations.qrCodeSelectedRow,
        AppLocalizations.manualSelectedRow,
        AppLocalizations.toAnotherDeviceSelectedRow,
      ];
    }
    return [
      AppLocalizations.qrCodeSelectedRow,
      AppLocalizations.manualSelectedRow,
      AppLocalizations.toAnotherDeviceSelectedRow,
    ];
  }

  @override
  void initState() {
    super.initState();
    _loadSubscriberData();
  }

  void _loadSubscriberData() async {
    final authDataSource = sl.get<AuthLocalDataSource>();
    final subscriberBloc = context.read<SubscriberBloc>();
    try {
      final token = await authDataSource.getToken();
      if (token != null && mounted) {
        subscriberBloc.add(LoadSubscriberInfoEvent(token: token));
      } else {
        subscriberBloc.add(const ResetSubscriberStateEvent());
      }
    } catch (e) {
      if (kDebugMode) {
        print('Esim Setup Screen: Error loading token: $e');
      }
      subscriberBloc.add(const ResetSubscriberStateEvent());
    }
  }


  @override
  Widget build(BuildContext context) {
    final options = getRowOptions();

    if (kDebugMode) {
      print(PlatformDetector.platformLog);
    }
    return BlocProvider(
      create: (_) => EsimSetupBloc(options: options)..add(const LoadImsiListLength()),
      child: Scaffold(
        backgroundColor: const Color(0xFFD0DEEB),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100,
              pinned: true,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              leading: Transform.translate(
                offset: const Offset(-12, 0),
                child: BackButton(
                  color: Colors.black,
                  onPressed: () => NavigationService.pop(context),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: const EdgeInsets.only(bottom: 16),
                expandedTitleScale: 1.4,
                title: HelveticaneueFont(
                  text: AppLocalizations.installEsim,
                  fontSize: 20,
                  letterSpacing: -0.5,
                  height: 1.1,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF363C45),
                ),
                background: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: safePaddingArea(context) + 56,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 40,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      BlocBuilder<EsimSetupBloc, EsimSetupState>(
                        builder: (context, state) {
                          if (state is EsimSetupLoading ||
                              state is EsimSetupInitial) {
                            return const SizedBox(height: 48);
                          }

                          if (state is EsimSetupError) {
                            return Text(state.message); 
                          }

                          if (state is EsimSetupLoaded) {
                            return LazyRow(
                              selectedIndex: state.selectedIndex,
                              options: options,
                              onSelectedIndex: (index) {
                                context.read<EsimSetupBloc>().add(
                                  SelectOption(index),
                                );
                              },
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                      BlocBuilder<EsimSetupBloc, EsimSetupState>(
                        builder: (context, state) {
                          if (state is EsimSetupLoaded) {
                            return Column(
                              children: [
                                const SizedBox(height: 25),
                                BlocBuilder<SubscriberBloc, SubscriberState>(
                                  builder: (context, subscriberState) {
                                    String? qrCode;
                                    bool isLoading = false;
                                    String? errorMessage;

                                    if (subscriberState is SubscriberLoading) {
                                      isLoading = true;
                                    } else if (subscriberState is SubscriberLoaded) {
                                      final list = subscriberState.subscriber.imsiList;
                                      if (list.isNotEmpty && list.last.qr != null && list.last.qr!.isNotEmpty) {
                                        qrCode = list.last.qr;
                                      } else {
                                        errorMessage = 'QR IS NOT AVAILABLE';
                                      }
                                    } else if (subscriberState is SubscriberError) {
                                      errorMessage = subscriberState.message;
                                    }

                                    return _buildSelectedBody(
                                      options[state.selectedIndex],
                                      qrCode: qrCode,
                                      isLoading: isLoading,
                                      errorMessage: errorMessage,
                                    );
                                  },
                                ),
                              ],
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Column(
                children: [SizedBox(height: 16), BottomSetupContainer()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSelectedBody(
  String option, {
  String? qrCode,
  bool isLoading = false,
  String? errorMessage,
}) {
  switch (option) {
    case AppLocalizations.fastSelectedRow:
      return const FastSelectedBody();
    case AppLocalizations.qrCodeSelectedRow:
      return QrCodeSelectedBody(
        qrCode: qrCode,
        isLoading: isLoading,
        errorMessage: errorMessage,
      );
    case AppLocalizations.manualSelectedRow:
      return const ManualSelectedBody();
    case AppLocalizations.toAnotherDeviceSelectedRow:
      return const AnotherDeviceSelectedBody();
    default:
      return const SizedBox.shrink();
  }
}