abstract class PaymentRepository {
  Future<bool> topUpBalance(int amount, String imsi);
  Future<bool> purchaseEsim({String? tariffId, int? amount});
}
