import 'package:flex_travel_sim/features/authentication/data/data_sources/confirm_number_remote_data_source.dart';
import 'package:flex_travel_sim/features/authentication/domain/repo/confirm_number_repository.dart';

class ConfirmNumberRepositoryImpl implements ConfirmNumberRepository {
  final ConfirmNumberRemoteDataSource remoteDataSource;

  ConfirmNumberRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> confirmNumber(String token, String ticketCode) async {
    await remoteDataSource.confirmNumber(token: token, ticketCode: ticketCode);
  }
}
