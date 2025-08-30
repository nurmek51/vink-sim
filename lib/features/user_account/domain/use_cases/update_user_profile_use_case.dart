import 'package:flex_travel_sim/core/utils/result.dart';
import 'package:flex_travel_sim/features/user_account/domain/entities/user.dart';
import 'package:flex_travel_sim/features/user_account/domain/repositories/user_repository.dart';

class UpdateUserProfileUseCase {
  final UserRepository repository;

  UpdateUserProfileUseCase(this.repository);

  Future<Result<User>> call(Map<String, dynamic> userData) async {
    final validationResult = _validateUserData(userData);
    if (validationResult != null) {
      return Failure(validationResult);
    }

    return await repository.updateUserProfile(userData);
  }

  String? _validateUserData(Map<String, dynamic> userData) {
    if (userData.isEmpty) {
      return 'User data cannot be empty';
    }

    if (userData.containsKey('email')) {
      final email = userData['email'] as String?;
      if (email != null && !_isValidEmail(email)) {
        return 'Invalid email format';
      }
    }

    if (userData.containsKey('phone_number')) {
      final phone = userData['phone_number'] as String?;
      if (phone != null && !_isValidPhoneNumber(phone)) {
        return 'Invalid phone number format';
      }
    }

    if (userData.containsKey('first_name')) {
      final firstName = userData['first_name'] as String?;
      if (firstName != null && firstName.trim().isEmpty) {
        return 'First name cannot be empty';
      }
    }

    if (userData.containsKey('last_name')) {
      final lastName = userData['last_name'] as String?;
      if (lastName != null && lastName.trim().isEmpty) {
        return 'Last name cannot be empty';
      }
    }

    return null;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhoneNumber(String phone) {
    return RegExp(
      r'^\+?[1-9]\d{1,14}$',
    ).hasMatch(phone.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }
}
