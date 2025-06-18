import 'package:flex_travel_sim/features/authentication/domain/repo/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<String?> call(String phone) async {
    return await repository.login(phone);
  }
}
