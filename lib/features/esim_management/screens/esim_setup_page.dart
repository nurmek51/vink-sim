import 'package:vink_sim/components/widgets/helvetica_neue_font.dart';
import 'package:vink_sim/core/layout/screen_utils.dart';
import 'package:vink_sim/l10n/app_localizations.dart';
import 'package:vink_sim/core/platform_device/platform_detector.dart';
import 'package:vink_sim/features/esim_management/bloc/esim_setup_bloc.dart';
import 'package:vink_sim/features/esim_management/widgets/setup/another_device_selected_body.dart';
import 'package:vink_sim/features/esim_management/widgets/setup/bottom_setup_container.dart';
import 'package:vink_sim/features/esim_management/widgets/setup/lazy_row.dart';
import 'package:vink_sim/features/esim_management/widgets/setup/fast_selected_body.dart';
import 'package:vink_sim/features/esim_management/widgets/setup/manual_selected_body.dart';
import 'package:vink_sim/features/esim_management/widgets/setup/qr_code_selected_body.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_event.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_state.dart';
import 'package:vink_sim/utils/navigation_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EsimSetupPage extends StatefulWidget {
  final bool isActivatedEsimScreen;
  const EsimSetupPage({super.key, this.isActivatedEsimScreen = false});

  @override
  State<EsimSetupPage> createState() => _EsimSetupPageState();
}

class _EsimSetupPageState extends State<EsimSetupPage> {
  static const String _baseActivationPrefix = "LPA:1\$smdp.io\$";

  List<String> getRowOptions() {
    // Show Fast option for both iOS and Android
    if (PlatformDetector.isIos || PlatformDetector.isAndroid) {
      return [
        SimLocalizations.of(context)!.fast_selected_row,
        SimLocalizations.of(context)!.qr_code_selected_row,
        SimLocalizations.of(context)!.manual_selected_row,
        SimLocalizations.of(context)!.to_another_device_selected_row,
      ];
    }
    return [
      SimLocalizations.of(context)!.qr_code_selected_row,
      SimLocalizations.of(context)!.manual_selected_row,
      SimLocalizations.of(context)!.to_another_device_selected_row,
    ];
  }

  @override
  void initState() {
    super.initState();
    _loadSubscriberData();
  }

  void _loadSubscriberData() async {
    final subscriberBloc = context.read<SubscriberBloc>();
    try {
      if (mounted) {
        subscriberBloc.add(const LoadSubscriberInfoEvent());
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
      create:
          (_) =>
              EsimSetupBloc(options: options)..add(const LoadImsiListLength()),
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
                  text: SimLocalizations.of(context)!.install_esim,
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
                                    String? smdpServer;
                                    String? activationCode;
                                    bool isLoading = false;
                                    String? errorMessage;

                                    if (subscriberState is SubscriberLoading) {
                                      isLoading = true;
                                    } else if (subscriberState
                                        is SubscriberLoaded) {
                                      final list =
                                          subscriberState.subscriber.imsiList;

                                      if (list.isNotEmpty &&
                                          list.last.activationCode != null &&
                                          list
                                              .last
                                              .activationCode!
                                              .isNotEmpty) {
                                        final lastImsiIndex = list.last;
                                        activationCode =
                                            lastImsiIndex.activationCode;
                                        qrCode =
                                            _baseActivationPrefix +
                                            activationCode!;
                                        smdpServer = "smdp.io";
                                      } else {
                                        errorMessage =
                                            SimLocalizations.of(
                                              context,
                                            )!.not_available;
                                      }
                                    } else if (subscriberState
                                        is SubscriberError) {
                                      errorMessage =
                                          SimLocalizations.of(
                                            context,
                                          )!.not_available;
                                      if (kDebugMode) {
                                        print(
                                          'Subscriber Error: ${subscriberState.message}',
                                        );
                                      }
                                    }

                                    return _buildSelectedBody(
                                      context,
                                      options[state.selectedIndex],
                                      qrCode: qrCode,
                                      smdpServer: smdpServer,
                                      activationCode: activationCode,
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
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  BottomSetupContainer(
                    isActivatedEsimScreen: widget.isActivatedEsimScreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSelectedBody(
  BuildContext context,
  String option, {
  String? qrCode,
  String? smdpServer,
  String? activationCode,
  bool isLoading = false,
  String? errorMessage,
}) {
  if (option == SimLocalizations.of(context)!.fast_selected_row) {
    return FastSelectedBody(
      smdpServer: smdpServer,
      activationCode: activationCode,
      fullActivationString: qrCode,
      isLoading: isLoading,
      errorMessage: errorMessage,
    );
  } else if (option == SimLocalizations.of(context)!.qr_code_selected_row) {
    return QrCodeSelectedBody(
      qrCode: qrCode,
      isLoading: isLoading,
      errorMessage: errorMessage,
    );
  } else if (option == SimLocalizations.of(context)!.manual_selected_row) {
    return ManualSelectedBody(
      smdpServer: smdpServer,
      activationCode: activationCode,
      isLoading: isLoading,
      errorMessage: errorMessage,
    );
  } else if (option ==
      SimLocalizations.of(context)!.to_another_device_selected_row) {
    return AnotherDeviceSelectedBody(
      qrCode: qrCode,
      isLoading: isLoading,
      errorMessage: errorMessage,
    );
  } else {
    return const SizedBox.shrink();
  }
}
