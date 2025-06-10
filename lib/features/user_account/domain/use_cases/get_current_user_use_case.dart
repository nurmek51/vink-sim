import 'package:flex_travel_sim/core/error/failures.dart';
import 'package:flex_travel_sim/features/esim_management/domain/repositories/esim_repository.dart';
import 'package:flex_travel_sim/features/user_account/domain/entities/user.dart';
import 'package:flex_travel_sim/features/user_account/domain/repositories/user_repository.dart';

class GetCurrentUserUseCase {
  final UserRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, User>> call({bool forceRefresh = false}) async {
    return await repository.getCurrentUser(forceRefresh: forceRefresh);
  }
}
