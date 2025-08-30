import 'package:flex_travel_sim/core/utils/result.dart';
import 'package:flex_travel_sim/features/auth/domain/entities/confirm_method.dart';
import 'package:flex_travel_sim/features/auth/domain/repo/auth_repository.dart';

class ConfirmUseCase {
  final AuthRepository repository;

  ConfirmUseCase({ required this.repository });

  Future<Result<void>> call({
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