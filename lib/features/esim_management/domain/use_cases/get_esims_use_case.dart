import 'package:vink_sim/core/utils/result.dart';
import 'package:vink_sim/features/esim_management/domain/entities/esim.dart';
import 'package:vink_sim/features/esim_management/domain/repositories/esim_repository.dart';

class GetEsimsUseCase {
  final EsimRepository repository;

  GetEsimsUseCase(this.repository);

  Future<Result<List<Esim>>> call({bool forceRefresh = false}) async {
    return await repository.getEsims(forceRefresh: forceRefresh);
  }
}
