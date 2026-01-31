import 'package:vink_sim/core/utils/result.dart';
import 'package:vink_sim/features/auth/domain/entities/auth_token.dart';
import 'package:vink_sim/features/auth/domain/repo/auth_repository.dart';
import 'package:vink_sim/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:vink_sim/features/auth/data/data_sources/otp_auth_data_source.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/config/feature_config.dart';

class AuthRepositoryImpl implements AuthRepository {
  final OtpAuthDataSource otpDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.otpDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<void>> requestOtp(String phone) async {
    return ResultHelper.safeCall(() async {
      await otpDataSource.sendOtpSms(phone);
    });
  }

  @override
  Future<Result<AuthToken>> verifyOtp(String phone, String otp) async {
    return ResultHelper.safeCall(() async {
      final response = await otpDataSource.verifyOtp(phone, otp);
      await localDataSource.saveToken(response.token);

      // Notify host app via FeatureConfig if available
      if (sl.isRegistered<FeatureConfig>()) {
        sl.get<FeatureConfig>().onAuthSuccess?.call(response.token, 604800);
      }

      return AuthToken(response.token);
    });
  }

  @override
  Future<Result<void>> logout() async {
    return ResultHelper.safeCall(() async {
      await localDataSource.removeToken();

      // Notify host app via FeatureConfig if available
      if (sl.isRegistered<FeatureConfig>()) {
        sl.get<FeatureConfig>().onLogout?.call();
      }
    });
  }

  @override
  Future<Result<bool>> isAuthenticated() async {
    return ResultHelper.safeCall(() async {
      final token = await localDataSource.getToken();
      return token != null && token.isNotEmpty;
    });
  }
}
