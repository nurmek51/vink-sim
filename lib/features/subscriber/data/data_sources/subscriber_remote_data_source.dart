import 'package:flex_travel_sim/core/network/travel_sim_api_service.dart';
import 'package:flex_travel_sim/core/models/subscriber_model.dart';
import 'package:flutter/foundation.dart';

abstract class SubscriberRemoteDataSource {
  Future<SubscriberModel> getSubscriberInfo(String token);
}

class SubscriberRemoteDataSourceImpl implements SubscriberRemoteDataSource {
  final TravelSimApiService _travelSimApiService;

  SubscriberRemoteDataSourceImpl({
    required TravelSimApiService travelSimApiService,
  }) : _travelSimApiService = travelSimApiService;

  @override
  Future<SubscriberModel> getSubscriberInfo(String token) async {
    try {
      if (kDebugMode) {
        print('Subscriber: Getting subscriber info');
      }

      final response = await _travelSimApiService.getSubscriberInfo(token);
      
      if (kDebugMode) {
        print('Subscriber: Raw API response: $response');
        print('Subscriber: Response type: ${response.runtimeType}');
        print('Subscriber: Response keys: ${response.keys}');
      }
      
      final subscriber = SubscriberModel.fromJson(response);

      if (kDebugMode) {
        print('Subscriber: Info retrieved successfully');
        print('Balance: ${subscriber.balance}');
        print('IMSI Count: ${subscriber.imsiList.length}');
        for (int i = 0; i < subscriber.imsiList.length; i++) {
          final imsi = subscriber.imsiList[i];
          print('IMSI $i: ${imsi.imsi}, Balance: ${imsi.balance}, Rate: ${imsi.rate}, Country: ${imsi.country}');
        }
      }

      return subscriber;
    } catch (e) {
      if (kDebugMode) {
        print('Subscriber: Failed to get info - $e');
      }
      throw Exception('Failed to get subscriber info: $e');
    }
  }
}