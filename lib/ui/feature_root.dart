import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vink_sim/config/feature_config.dart';
import 'package:vink_sim/core/config/environment.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/core/router/app_router.dart';
import 'package:vink_sim/features/dashboard/bloc/main_flow_bloc.dart';
import 'package:vink_sim/features/onboarding/bloc/welcome_bloc.dart';
import 'package:vink_sim/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';

class FeatureRoot extends StatefulWidget {
  final FeatureConfig config;

  const FeatureRoot({super.key, required this.config});

  @override
  State<FeatureRoot> createState() => _FeatureRootState();
}

class _FeatureRootState extends State<FeatureRoot> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(FeatureRoot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.config != oldWidget.config) {
      _updateConfig();
    }
  }

  Future<void> _updateConfig() async {
    try {
      if (sl.isRegistered<FeatureConfig>()) {
        await sl.unregister<FeatureConfig>();
      }
      sl.registerSingleton<FeatureConfig>(widget.config);
    } catch (e) {
      debugPrint('FeatureRoot config update error: $e');
    }
  }

  Future<void> _init() async {
    try {
      if (widget.config.apiBaseUrl == null) {
        try {
          await Environment.load();
        } catch (e) {
          debugPrint('FeatureRoot: Environment load warning: $e');
        }
      }

      await DependencyInjection.initForFeature(widget.config);
    } catch (e) {
      debugPrint('FeatureRoot init error: $e');
    }
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    // If running standalone (not shell mode), we might need to wrap in MaterialApp
    // to provide localizations. But FeatureRoot contract says it returns a Widget.
    // If the parent (Shell) provides MaterialApp, we are good.
    // If we are running example app, the example app should provide MaterialApp.
    // However, to ensure SimLocalizations are available if the shell forgot them (though we added them),
    // we can't easily inject them here without a MaterialApp.
    // We assume the Shell (VinkApp) has added SimLocalizations.delegate.

    return Builder(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => MainFlowBloc()),
            BlocProvider(create: (_) => sl<WelcomeBloc>()),
            BlocProvider(create: (_) => sl<PaymentBloc>()),
            BlocProvider(create: (_) => sl<SubscriberBloc>()),
          ],
          child: Router.withConfig(config: AppRouter.router),
        );
      },
    );
  }
}
