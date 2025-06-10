import 'package:flex_travel_sim/features/onboarding/cubit/resend_code_timer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendCodeTimer extends StatelessWidget {
  final VoidCallback? onResend;
  const ResendCodeTimer({super.key, this.onResend});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResendCodeTimerCubit(),
      child: BlocBuilder<ResendCodeTimerCubit, ResendCodeTimerState>(
        builder: (context, state) {
          return Center(
            child: state.canResend
              ? GestureDetector(
                  onTap: () {
                    context.read<ResendCodeTimerCubit>().resendCode();
                    onResend?.call();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16, 
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Отправить код повторно',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : Text(
                  'Отправить код повторно через ${state.secondsRemaining} сек',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
          );
        },
      ),
    );
  }
}
