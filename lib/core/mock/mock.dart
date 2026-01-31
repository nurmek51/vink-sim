/// Mock Data Library for FlexTravelSIM
///
/// This library exports all mock data classes for easy importing.
///
/// Usage:
/// ```dart
/// import 'package:vink_sim/core/mock/mock.dart';
///
/// // Check if mock mode is enabled
/// if (MockConfig.useMockData) {
///   // Use mock data
/// }
///
/// // Access mock user data
/// final user = MockUserData.currentUser;
///
/// // Access mock subscriber data
/// final subscriber = MockSubscriberData.subscriber;
/// ```

library;

export 'mock_data.dart';
