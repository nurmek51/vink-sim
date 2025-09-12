import 'package:flex_travel_sim/core/config/environment.dart';
import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flex_travel_sim/core/router/app_router.dart';
import 'package:flex_travel_sim/core/services/token_manager.dart';
import 'package:flex_travel_sim/core/services/configuration_service.dart';
import 'package:flex_travel_sim/features/stripe_payment/presentation/bloc/stripe_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/features/dashboard/bloc/main_flow_bloc.dart';
import 'package:flex_travel_sim/features/onboarding/bloc/welcome_bloc.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_travel_sim/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Load environment variables based on build mode
  await Environment.load();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      print('Firebase successfully initialized');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Firebase initialization error: $e');
    }
  }

  await DependencyInjection.init();

  final configService = sl<ConfigurationService>();
  Stripe.publishableKey = configService.stripePublishableKey;
  Stripe.merchantIdentifier = configService.stripeMerchantIdentifier;

  // Initialize token manager for automatic token refresh
  try {
    final tokenManager = sl<TokenManager>();
    tokenManager.initialize();
    if (kDebugMode) {
      print('TokenManager initialized successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('TokenManager initialization failed: $e');
    }
  }

  await Future.delayed(const Duration(seconds: 2));

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainFlowBloc()),
        BlocProvider(create: (_) => sl<WelcomeBloc>()),
        BlocProvider(create: (_) => sl<StripeBloc>()),
        BlocProvider(create: (_) => sl<SubscriberBloc>()),
      ],
      child: MaterialApp.router(
        title: 'FlexTravelSIM',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.blue,
        ),
        routerConfig: AppRouter.router,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
