import 'package:flex_travel_sim/features/onboarding/auth_by_email/domain/repo/confirm_email_repository.dart';

class ConfirmEmailUseCase {
  final ConfirmEmailRepository repository;

  ConfirmEmailUseCase({required this.repository});

  Future<void> call(String token, String ticketCode) async {
    await repository.confirmEmail(token, ticketCode);
  }
}
