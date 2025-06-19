abstract class AuthByEmailRepository {
  Future<String?> loginByEmail(String email);
  Future<void> logout();
}
