import 'package:flex_travel_sim/features/onboarding/cubit/resend_code_timer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendCodeTimer extends StatelessWidget {
  const ResendCodeTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResendCodeTimerCubit(),
      child: BlocBuilder<ResendCodeTimerCubit, ResendCodeTimerState>(
        builder: (context, state) {
          if (state.canResend) {
            return Center(
              child: GestureDetector(
                onTap: () => context.read<ResendCodeTimerCubit>().resendCode(),
                child: Text(
                  'Отправить код повторно',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                'Отправить код повторно (${state.secondsRemaining})',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
