import 'package:vink_sim/core/utils/result.dart';
import 'package:vink_sim/features/user_account/domain/entities/user.dart';
import 'package:vink_sim/features/user_account/domain/repositories/user_repository.dart';

class GetCurrentUserUseCase {
  final UserRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Result<User>> call({bool forceRefresh = false}) async {
    return await repository.getCurrentUser(forceRefresh: forceRefresh);
  }
}
