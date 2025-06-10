import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flex_travel_sim/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/features/onboarding/cubit/welcome_cubit.dart';
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
        BlocProvider(create: (_) => WelcomeCubit()),
        BlocProvider(create: (_) => MainFlowBloc()),
        BlocProvider(
          create: (_) => EsimBloc(
            getEsimsUseCase: sl.get<GetEsimsUseCase>(),
            activateEsimUseCase: sl.get<ActivateEsimUseCase>(),
            purchaseEsimUseCase: sl.get<PurchaseEsimUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => UserBloc(
            getCurrentUserUseCase: sl.get<GetCurrentUserUseCase>(),
            updateUserProfileUseCase: sl.get<UpdateUserProfileUseCase>(),
          ),
        ),
        // TopUpBalanceCubit и EsimSetupCubit создаются локально в своих экранах
        // ResendCodeTimerCubit также создается локально в виджете
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
