import 'package:vink_sim/core/storage/local_storage.dart';

abstract class SubscriberLocalDataSource {
  Future<void> saveImsiListLength(int imsiListLength);
  Future<int?> getImsiListLength();
  Future<void> removeImsiListLength();
  Future<void> resetImsiListLength();
  
}

class SubscriberLocalDataSourceImpl implements SubscriberLocalDataSource {
  final LocalStorage localStorage;
  static const _imsiListKey = 'imsi_list_length';

  SubscriberLocalDataSourceImpl({ required this.localStorage });

  @override
  Future<void> saveImsiListLength(int imsiListLength) =>
    localStorage.setInt(_imsiListKey, imsiListLength);

  @override
  Future<int?> getImsiListLength() =>
    localStorage.getInt(_imsiListKey);

  @override
  Future<void> removeImsiListLength() =>
    localStorage.remove(_imsiListKey);

  @override  
  Future<void> resetImsiListLength() => saveImsiListLength(0);  
}