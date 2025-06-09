import 'package:flex_travel_sim/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_travel_sim/features/onboarding/cubit/welcome_cubit.dart';
import 'package:flex_travel_sim/features/dashboard/bloc/main_flow_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WelcomeCubit()),
        BlocProvider(create: (_) => MainFlowBloc()),
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
