import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flex_travel_sim/core/router/app_router.dart';
import 'package:flex_travel_sim/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flex_travel_sim/features/onboarding/auth_by_email/presentation/bloc/auth_by_email_bloc.dart';
import 'package:flex_travel_sim/features/onboarding/auth_by_email/presentation/bloc/confirm_email_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/features/onboarding/bloc/welcome_bloc.dart';
import 'package:flex_travel_sim/features/dashboard/bloc/main_flow_bloc.dart';
import 'package:flex_travel_sim/features/esim_management/presentation/bloc/esim_bloc.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/get_esims_use_case.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/activate_esim_use_case.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/purchase_esim_use_case.dart';
import 'package:flex_travel_sim/features/user_account/presentation/bloc/user_bloc.dart';
import 'package:flex_travel_sim/features/user_account/domain/use_cases/get_current_user_use_case.dart';
import 'package:flex_travel_sim/features/user_account/domain/use_cases/update_user_profile_use_case.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await sl.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Onboarding Bloc
        BlocProvider(create: (_) => WelcomeBloc()),

        BlocProvider(create: (_) => sl.get<AuthBloc>()),     

        BlocProvider(create: (_) => sl.get<AuthByEmailBloc>()),

        BlocProvider(create: (_) => sl.get<ConfirmEmailBloc>()),
        
        // Dashboard Bloc
        BlocProvider(create: (_) => MainFlowBloc()),
        
        // eSIM Management Bloc
        BlocProvider(
          create: (_) => EsimBloc(
            getEsimsUseCase: sl.get<GetEsimsUseCase>(),
            activateEsimUseCase: sl.get<ActivateEsimUseCase>(),
            purchaseEsimUseCase: sl.get<PurchaseEsimUseCase>(),
          ),
        ),
        
        // User Account Bloc
        BlocProvider(
          create: (_) => UserBloc(
            getCurrentUserUseCase: sl.get<GetCurrentUserUseCase>(),
            updateUserProfileUseCase: sl.get<UpdateUserProfileUseCase>(),
          ),
        ),
        
        // Примечание: Локальные Bloc'ы создаются в своих экранах:
        // - TopUpBalanceBloc создается в TopUpBalanceScreen
        // - EsimSetupBloc создается в EsimSetupPage
        // - ResendCodeTimerBloc создается в виджетах с таймером
      ],
      child: MaterialApp.router(
        title: 'FlexTravelSIM',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
