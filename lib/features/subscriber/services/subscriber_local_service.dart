import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/features/subscriber/data/data_sources/subscriber_local_data_source.dart';
import 'package:flutter/foundation.dart';

class SubscriberLocalService {
  static Future<void> resetImsiList({required String screenRoute}) async {
    final subscriberDataSource = sl.get<SubscriberLocalDataSource>();
    try {
      await subscriberDataSource.resetImsiListLength();
      if (kDebugMode) {
        print('Local ImsiList Length: IMSI list length reset to 0 ($screenRoute)');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Local ImsiList Length: Failed to reset IMSI list length: $e');
      }
    }
  }

  static Future<void> saveImsiListLength({required int length, required String screenRoute}) async {
    final subscriberDataSource = sl.get<SubscriberLocalDataSource>();
    try {
      await subscriberDataSource.saveImsiListLength(length);
      if (kDebugMode) {
        print('Local ImsiList Length: Saved $length ($screenRoute)');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Local ImsiList Length: Failed to save IMSI list length: $e');
      }
    }
  }

}