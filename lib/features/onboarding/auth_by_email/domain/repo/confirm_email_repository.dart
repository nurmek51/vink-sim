abstract class ConfirmEmailRepository {
  Future<void> confirmEmail(String token, String ticketCode);
}