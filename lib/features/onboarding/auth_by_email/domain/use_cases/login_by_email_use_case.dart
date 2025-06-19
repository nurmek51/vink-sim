import 'package:flex_travel_sim/features/onboarding/auth_by_email/domain/repo/auth_by_email_repository.dart';

class LoginByEmailUseCase {
  final AuthByEmailRepository repository;

  LoginByEmailUseCase({required this.repository});

  Future<String?> call(String email) async {
    return await repository.loginByEmail(email);
  }
}
