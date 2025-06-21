abstract class ConfirmNumberRepository {
  Future<void> confirmNumber(String token, String ticketCode);
}