import 'package:flex_travel_sim/core/error/failures.dart';
import 'package:flex_travel_sim/features/esim_management/domain/entities/esim.dart';
import 'package:flex_travel_sim/features/esim_management/domain/repositories/esim_repository.dart';

class ActivateEsimUseCase {
  final EsimRepository repository;

  ActivateEsimUseCase(this.repository);

  Future<Either<Failure, Esim>> call(String id, String activationCode) async {
    if (id.isEmpty) {
      return const Left(ValidationFailure('eSIM ID cannot be empty'));
    }

    if (activationCode.isEmpty) {
      return const Left(ValidationFailure('Activation code cannot be empty'));
    }

    return await repository.activateEsim(id, activationCode);
  }
}
