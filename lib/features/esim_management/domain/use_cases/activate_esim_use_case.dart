import 'package:vink_sim/core/utils/result.dart';
import 'package:vink_sim/features/esim_management/domain/entities/esim.dart';
import 'package:vink_sim/features/esim_management/domain/repositories/esim_repository.dart';

class ActivateEsimUseCase {
  final EsimRepository repository;

  ActivateEsimUseCase(this.repository);

  Future<Result<Esim>> call(String id, String activationCode) async {
    if (id.isEmpty) {
      return const Failure('eSIM ID cannot be empty');
    }

    if (activationCode.isEmpty) {
      return const Failure('Activation code cannot be empty');
    }

    return await repository.activateEsim(id, activationCode);
  }
}
