import 'package:flex_travel_sim/features/onboarding/auth_by_email/data/data_sources/confirm_email_remote_data_source.dart';
import 'package:flex_travel_sim/features/onboarding/auth_by_email/domain/repo/confirm_email_repository.dart';

class ConfirmEmailRepositoryImpl implements ConfirmEmailRepository {
  final ConfirmEmailRemoteDataSource remoteDataSource;

  ConfirmEmailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> confirmEmail(String token, String ticketCode) async {
    await remoteDataSource.confirmEmail(token: token, ticketCode: ticketCode);
  }
}
