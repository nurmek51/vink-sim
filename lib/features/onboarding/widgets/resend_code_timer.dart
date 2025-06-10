import 'package:flex_travel_sim/features/onboarding/bloc/resend_code_timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendCodeTimer extends StatelessWidget {
  final VoidCallback? onResend;
  const ResendCodeTimer({super.key, this.onResend});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResendCodeTimerBloc(),
      child: BlocBuilder<ResendCodeTimerBloc, ResendCodeTimerState>(
        builder: (context, state) {
          return Center(
            child: state.canResend
              ? GestureDetector(
                  onTap: () {
                    context.read<ResendCodeTimerBloc>().add(const ResendCode());
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
