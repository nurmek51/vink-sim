import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flex_travel_sim/features/user_account/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getCurrentUser();
  Future<UserModel> updateUserProfile(Map<String, dynamic> userData);
  Future<void> updateBalance(double amount);
  Future<Map<String, dynamic>> getBalanceHistory();
  Future<void> deleteUser();
  Future<UserModel> uploadAvatar(String filePath);
  Future<void> changePassword(String oldPassword, String newPassword);
  Future<void> verifyEmail(String verificationCode);
  Future<void> verifyPhone(String verificationCode);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient _apiClient;

  UserRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await _apiClient.get('/user/profile');

    return UserModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<UserModel> updateUserProfile(Map<String, dynamic> userData) async {
    final response = await _apiClient.put('/user/profile', body: userData);

    return UserModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> updateBalance(double amount) async {
    await _apiClient.post('/user/balance/top-up', body: {'amount': amount});
  }

  @override
  Future<Map<String, dynamic>> getBalanceHistory() async {
    final response = await _apiClient.get('/user/balance/history');

    return response['data'] as Map<String, dynamic>;
  }

  @override
  Future<void> deleteUser() async {
    await _apiClient.delete('/user/profile');
  }

  @override
  Future<UserModel> uploadAvatar(String filePath) async {
    final response = await _apiClient.post(
      '/user/avatar',
      body: {'avatar_path': filePath},
    );

    return UserModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    await _apiClient.post(
      '/user/change-password',
      body: {'old_password': oldPassword, 'new_password': newPassword},
    );
  }

  @override
  Future<void> verifyEmail(String verificationCode) async {
    await _apiClient.post(
      '/user/verify-email',
      body: {'verification_code': verificationCode},
    );
  }

  @override
  Future<void> verifyPhone(String verificationCode) async {
    await _apiClient.post(
      '/user/verify-phone',
      body: {'verification_code': verificationCode},
    );
  }
}
