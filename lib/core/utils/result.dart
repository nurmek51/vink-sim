import 'package:equatable/equatable.dart';

abstract class Result<T> extends Equatable {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => isSuccess ? (this as Success<T>).data : null;
  String? get error => isFailure ? (this as Failure<T>).message : null;

  R fold<R>(
    R Function(String error) onFailure,
    R Function(T data) onSuccess,
  ) {
    if (isSuccess) {
      return onSuccess((this as Success<T>).data);
    } else {
      return onFailure((this as Failure<T>).message);
    }
  }
}

class Success<T> extends Result<T> {
  @override
  final T data;

  const Success(this.data);

  @override
  List<Object?> get props => [data];

  @override
  String toString() => 'Success(data: $data)';
}

class Failure<T> extends Result<T> {
  final String message;
  final String? code;
  final dynamic originalError;

  const Failure(
    this.message, {
    this.code,
    this.originalError,
  });

  @override
  List<Object?> get props => [message, code, originalError];

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

extension ResultExtensions<T> on Result<T> {
  Result<R> map<R>(R Function(T data) transform) {
    return fold(
      (error) => Failure<R>(error),
      (data) => Success<R>(transform(data)),
    );
  }

  Future<Result<R>> asyncMap<R>(Future<R> Function(T data) transform) async {
    return fold(
      (error) => Failure<R>(error),
      (data) async => Success<R>(await transform(data)),
    );
  }
}

class ResultHelper {
  static Future<Result<T>> safeCall<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Success(result);
    } catch (error) {
      return Failure(error.toString(), originalError: error);
    }
  }

  static Result<T> safeSyncCall<T>(T Function() call) {
    try {
      final result = call();
      return Success(result);
    } catch (error) {
      return Failure(error.toString(), originalError: error);
    }
  }
}