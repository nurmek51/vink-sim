import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/auth/domain/repo/auth_repository.dart';

class ConfirmUseCase {
  final AuthRepository repository;

  ConfirmUseCase({ required this.repository });

  Future<void> call({
    required ConfirmMethod method,
    required String token,
    required String ticketCode,
  }) {
    return repository.confirm(
      method: method,
      token: token,
      ticketCode: ticketCode,
    );
  }
}