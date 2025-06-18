abstract class AuthRepository {
  Future<String?> login(String phone);
  Future<void> logout();
}
