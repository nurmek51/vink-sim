import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flex_travel_sim/core/router/app_router.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/confirm_bloc.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/firebase_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/features/dashboard/bloc/main_flow_bloc.dart';
import 'package:flex_travel_sim/features/esim_management/presentation/bloc/esim_bloc.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/get_esims_use_case.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/activate_esim_use_case.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/purchase_esim_use_case.dart';
import 'package:flex_travel_sim/features/user_account/presentation/bloc/user_bloc.dart';
import 'package:flex_travel_sim/features/user_account/domain/use_cases/get_current_user_use_case.dart';
import 'package:flex_travel_sim/features/user_account/domain/use_cases/update_user_profile_use_case.dart';
import 'package:flex_travel_sim/features/onboarding/bloc/welcome_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_travel_sim/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

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

  await sl.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
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
        BlocProvider(create: (_) => sl.get<AuthBloc>()),
        BlocProvider(create: (_) => sl.get<ConfirmBloc>()),
        BlocProvider(create: (_) => sl.get<FirebaseAuthBloc>()),
        BlocProvider(create: (_) => MainFlowBloc()),
        BlocProvider(
          create:
              (_) => EsimBloc(
                getEsimsUseCase: sl.get<GetEsimsUseCase>(),
                activateEsimUseCase: sl.get<ActivateEsimUseCase>(),
                purchaseEsimUseCase: sl.get<PurchaseEsimUseCase>(),
              ),
        ),
        BlocProvider(
          create:
              (_) => UserBloc(
                getCurrentUserUseCase: sl.get<GetCurrentUserUseCase>(),
                updateUserProfileUseCase: sl.get<UpdateUserProfileUseCase>(),
              ),
        ),
        BlocProvider(create: (_) => sl.get<WelcomeBloc>()),
      ],
      child: MaterialApp.router(
        title: 'FlexTravelSIM',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
