import 'package:vink_sim/core/network/api_client.dart';
import 'package:vink_sim/features/user_account/data/models/user_model.dart';
import 'package:flutter/foundation.dart';

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
    try {
      final response = await _apiClient.get('/subscriber');
      return UserModel.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      if (kDebugMode) print('UserRemoteDataSource: Error - $e');
      rethrow;
    }
  }

  @override
  Future<UserModel> updateUserProfile(Map<String, dynamic> userData) async {
    throw UnimplementedError('updateUserProfile not supported by backend');
  }

  @override
  Future<void> updateBalance(double amount) async {
    throw UnimplementedError('updateBalance not supported by backend');
  }

  @override
  Future<Map<String, dynamic>> getBalanceHistory() async {
    throw UnimplementedError('getBalanceHistory not supported by backend');
  }

  @override
  Future<void> deleteUser() async {
    throw UnimplementedError('deleteUser not supported by backend');
  }

  @override
  Future<UserModel> uploadAvatar(String filePath) async {
    throw UnimplementedError('uploadAvatar not supported by backend');
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    throw UnimplementedError('changePassword not supported by backend');
  }

  @override
  Future<void> verifyEmail(String verificationCode) async {
    throw UnimplementedError('verifyEmail not supported by backend');
  }

  @override
  Future<void> verifyPhone(String verificationCode) async {
    throw UnimplementedError('verifyPhone not supported by backend');
  }
}
