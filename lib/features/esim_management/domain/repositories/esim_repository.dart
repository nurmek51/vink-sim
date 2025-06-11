import 'package:flex_travel_sim/core/error/failures.dart';
import 'package:flex_travel_sim/features/esim_management/domain/entities/esim.dart';

abstract class EsimRepository {
  Future<Either<Failure, List<Esim>>> getEsims({bool forceRefresh = false});
  Future<Either<Failure, Esim>> getEsimById(String id);
  Future<Either<Failure, Esim>> activateEsim(String id, String activationCode);
  Future<Either<Failure, Esim>> purchaseEsim(String tariffId, Map<String, dynamic> paymentData);
  Future<Either<Failure, void>> deactivateEsim(String id);
  Future<Either<Failure, Esim>> updateEsimSettings(String id, Map<String, dynamic> settings);
  Future<Either<Failure, Map<String, dynamic>>> getEsimUsageData(String id);
}

// Either class для функционального программирования
abstract class Either<L, R> {
  const Either();
  
  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;
  
  L get left => (this as Left<L, R>).value;
  R get right => (this as Right<L, R>).value;
  
  T fold<T>(T Function(L left) leftFunction, T Function(R right) rightFunction) {
    if (isLeft) {
      return leftFunction(left);
    } else {
      return rightFunction(right);
    }
  }
}

class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Left && runtimeType == other.runtimeType && value == other.value;
  
  @override
  int get hashCode => value.hashCode;
}

class Right<L, R> extends Either<L, R> {
  final R value;
  const Right(this.value);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Right && runtimeType == other.runtimeType && value == other.value;
  
  @override
  int get hashCode => value.hashCode;
}
