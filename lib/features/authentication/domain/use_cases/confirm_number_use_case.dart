import 'package:flex_travel_sim/features/authentication/domain/repo/confirm_number_repository.dart';

class ConfirmNumberUseCase {
  final ConfirmNumberRepository repository;

  ConfirmNumberUseCase({required this.repository});

  Future<void> call(String token, String ticketCode) async {
    await repository.confirmNumber(token, ticketCode);
  }
}
