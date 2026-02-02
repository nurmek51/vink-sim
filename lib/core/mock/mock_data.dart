/// Mock Data for FlexTravelSIM Application
///
/// This file contains all mock data used for testing UI when the backend is unavailable.
/// To integrate real API, replace the mock implementations in data sources with actual API calls.
///
/// Mock User Credentials for Testing:
/// - Phone: +1234567890 (any code works)
/// - OTP Code: 123456 (default test code)
///

library;

import 'package:vink_sim/core/models/imsi_model.dart';
import 'package:vink_sim/core/models/subscriber_model.dart';
import 'package:vink_sim/features/esim_management/data/models/esim_model.dart';
import 'package:vink_sim/features/user_account/data/models/user_model.dart';

/// Configuration for mock behavior
class MockConfig {
  /// Enable/disable mock mode globally
  static bool useMockData = false;

  /// Simulate network delay (milliseconds)
  static int networkDelayMs = 300;

  /// Simulate random failures for testing error handling
  static bool simulateRandomFailures = false;
  static double failureRate = 0.1; // 10% failure rate

  /// Default OTP code that always works
  static const String defaultOtpCode = '123456';

  /// Test phone numbers
  static const String testPhoneNumber = '+1234567890';
}

/// Mock User Data
class MockUserData {
  static const String mockUserId = 'mock_user_001';
  static const String mockEmail = 'test@flextravelsim.com';
  static const String mockPhone = '+1234567890';

  static UserModel get currentUser => UserModel(
    id: mockUserId,
    email: mockEmail,
    firstName: 'John',
    lastName: 'Doe',
    phoneNumber: mockPhone,
    avatarUrl: null,
    balance: 50.00,
    currency: 'USD',
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
    updatedAt: DateTime.now(),
    isEmailVerified: true,
    isPhoneVerified: true,
    preferredLanguage: 'en',
    preferredCurrency: 'USD',
    favoriteCountries: ['US', 'GB', 'DE', 'JP', 'KZ'],
  );

  static Map<String, dynamic> get currentUserJson => currentUser.toJson();

  /// Mock auth token
  static String generateMockToken() {
    return 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Balance history
  static Map<String, dynamic> get balanceHistory => {
    'transactions': [
      {
        'id': 'txn_001',
        'type': 'top_up',
        'amount': 25.00,
        'currency': 'USD',
        'date':
            DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
        'status': 'completed',
        'description': 'Account top-up',
      },
      {
        'id': 'txn_002',
        'type': 'purchase',
        'amount': -10.00,
        'currency': 'USD',
        'date':
            DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
        'status': 'completed',
        'description': 'eSIM Purchase - Germany',
      },
      {
        'id': 'txn_003',
        'type': 'top_up',
        'amount': 35.00,
        'currency': 'USD',
        'date':
            DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        'status': 'completed',
        'description': 'Account top-up',
      },
    ],
    'total_top_up': 60.00,
    'total_spent': 10.00,
  };
}

/// Mock Subscriber Data (from TravelSIM API)
class MockSubscriberData {
  static SubscriberModel get subscriber =>
      SubscriberModel(balance: 50.00, imsiList: imsiList);

  static List<ImsiModel> get imsiList => [
    const ImsiModel(
      imsi: '250991234567890',
      iccid: '8922222220000000001',
      balance: 25.00,
      country: 'Germany',
      iso: 'DE',
      brand: 'FlexSIM',
      rate: 0.05,
      qr: 'LPA:1\$smdp.example.com\$ACTIVATION_CODE_GERMANY',
      smdpServer: 'smdp.example.com',
      activationCode: 'ACTIVATION_CODE_GERMANY',
    ),
    const ImsiModel(
      imsi: '250991234567891',
      iccid: '8922222220000000002',
      balance: 15.00,
      country: 'United Kingdom',
      iso: 'GB',
      brand: 'FlexSIM',
      rate: 0.06,
      qr: 'LPA:1\$smdp.example.com\$ACTIVATION_CODE_UK',
      smdpServer: 'smdp.example.com',
      activationCode: 'ACTIVATION_CODE_UK',
    ),
    const ImsiModel(
      imsi: '250991234567892',
      iccid: '8922222220000000003',
      balance: 10.00,
      country: 'Japan',
      iso: 'JP',
      brand: 'FlexSIM',
      rate: 0.08,
      qr: 'LPA:1\$smdp.example.com\$ACTIVATION_CODE_JP',
      smdpServer: 'smdp.example.com',
      activationCode: 'ACTIVATION_CODE_JP',
    ),
  ];

  static Map<String, dynamic> get subscriberJson => subscriber.toJson();
}

/// Mock eSIM Data
class MockEsimData {
  static List<EsimModel> get esimList => [
    EsimModel(
      id: 'esim_001',
      name: 'Germany Travel eSIM',
      provider: 'FlexSIM',
      country: 'Germany',
      region: 'Europe',
      isActive: true,
      dataUsed: 1.5,
      dataLimit: 5.0,
      activationDate: DateTime.now().subtract(const Duration(days: 3)),
      expirationDate: DateTime.now().add(const Duration(days: 27)),
      status: 'active',
      qrCode: 'LPA:1\$smdp.example.com\$ESIM_001_CODE',
      activationCode: 'ESIM_001_CODE',
      price: 15.00,
      currency: 'USD',
      supportedNetworks: ['Vodafone', 'T-Mobile', 'O2'],
    ),
    EsimModel(
      id: 'esim_002',
      name: 'UK Travel eSIM',
      provider: 'FlexSIM',
      country: 'United Kingdom',
      region: 'Europe',
      isActive: false,
      dataUsed: 0.0,
      dataLimit: 3.0,
      activationDate: null,
      expirationDate: null,
      status: 'pending_activation',
      qrCode: 'LPA:1\$smdp.example.com\$ESIM_002_CODE',
      activationCode: 'ESIM_002_CODE',
      price: 12.00,
      currency: 'USD',
      supportedNetworks: ['EE', 'Vodafone', 'Three'],
    ),
    EsimModel(
      id: 'esim_003',
      name: 'Japan Travel eSIM',
      provider: 'FlexSIM',
      country: 'Japan',
      region: 'Asia',
      isActive: false,
      dataUsed: 0.0,
      dataLimit: 10.0,
      activationDate: null,
      expirationDate: null,
      status: 'pending_activation',
      qrCode: 'LPA:1\$smdp.example.com\$ESIM_003_CODE',
      activationCode: 'ESIM_003_CODE',
      price: 25.00,
      currency: 'USD',
      supportedNetworks: ['NTT Docomo', 'au', 'SoftBank'],
    ),
  ];

  static List<Map<String, dynamic>> get esimListJson =>
      esimList.map((e) => e.toJson()).toList();

  static EsimModel getEsimById(String id) {
    return esimList.firstWhere((e) => e.id == id, orElse: () => esimList.first);
  }

  /// Mock usage data
  static Map<String, dynamic> getUsageData(String esimId) => {
    'esim_id': esimId,
    'period': {
      'start':
          DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
      'end': DateTime.now().toIso8601String(),
    },
    'usage': {
      'data_used_mb': 1536.0, // 1.5 GB
      'data_limit_mb': 5120.0, // 5 GB
      'data_remaining_mb': 3584.0,
      'percentage_used': 30.0,
    },
    'daily_breakdown': [
      {
        'date':
            DateTime.now().subtract(const Duration(days: 6)).toIso8601String(),
        'data_mb': 200.0,
      },
      {
        'date':
            DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
        'data_mb': 350.0,
      },
      {
        'date':
            DateTime.now().subtract(const Duration(days: 4)).toIso8601String(),
        'data_mb': 180.0,
      },
      {
        'date':
            DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
        'data_mb': 420.0,
      },
      {
        'date':
            DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        'data_mb': 156.0,
      },
      {
        'date':
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'data_mb': 230.0,
      },
      {'date': DateTime.now().toIso8601String(), 'data_mb': 0.0},
    ],
  };
}

/// Mock OTP/Auth Responses
class MockAuthData {
  /// Simulates OTP send response
  static Map<String, dynamic> get otpSendResponse => {
    'success': true,
    'message': 'OTP sent successfully',
    'expires_in': 300, // 5 minutes
  };

  /// Simulates OTP verification response
  static Map<String, dynamic> get otpVerifyResponse => {
    'token': MockUserData.generateMockToken(),
    'user_id': MockUserData.mockUserId,
  };

  /// Login response
  static Map<String, dynamic> get loginResponse => {
    'token': MockUserData.generateMockToken(),
    'user': MockUserData.currentUserJson,
    'refresh_token':
        'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
  };
}

/// Mock Tariffs Data
class MockTariffsData {
  static List<Map<String, dynamic>> get networkOperators => [
    {
      'PLMN': '26201',
      'NetworkName': 'Telekom',
      'CountryName': 'Germany',
      'DataRate': 0.05,
    },
    {
      'PLMN': '26202',
      'NetworkName': 'Vodafone',
      'CountryName': 'Germany',
      'DataRate': 0.06,
    },
    {
      'PLMN': '23410',
      'NetworkName': 'O2-UK',
      'CountryName': 'United Kingdom',
      'DataRate': 0.07,
    },
    {
      'PLMN': '23415',
      'NetworkName': 'Vodafone UK',
      'CountryName': 'United Kingdom',
      'DataRate': 0.06,
    },
    {
      'PLMN': '44010',
      'NetworkName': 'NTT Docomo',
      'CountryName': 'Japan',
      'DataRate': 0.08,
    },
    {
      'PLMN': '44020',
      'NetworkName': 'SoftBank',
      'CountryName': 'Japan',
      'DataRate': 0.09,
    },
    {
      'PLMN': '40101',
      'NetworkName': 'Beeline',
      'CountryName': 'Kazakhstan',
      'DataRate': 0.03,
    },
    {
      'PLMN': '40102',
      'NetworkName': 'Kcell',
      'CountryName': 'Kazakhstan',
      'DataRate': 0.03,
    },
    {
      'PLMN': '31026',
      'NetworkName': 'T-Mobile',
      'CountryName': 'United States',
      'DataRate': 0.10,
    },
    {
      'PLMN': '31012',
      'NetworkName': 'Verizon',
      'CountryName': 'United States',
      'DataRate': 0.12,
    },
  ];
}

/// Mock Payment Data
class MockPaymentData {
  static Map<String, dynamic> get paymentMethods => {
    'methods': [
      {
        'id': 'pm_001',
        'type': 'card',
        'last_four': '4242',
        'brand': 'Visa',
        'exp_month': 12,
        'exp_year': 2026,
        'is_default': true,
      },
      {'id': 'pm_002', 'type': 'apple_pay', 'is_default': false},
      {'id': 'pm_003', 'type': 'google_pay', 'is_default': false},
    ],
  };

  static Map<String, dynamic> createPaymentIntent({
    required double amount,
    required String currency,
  }) => {
    'id': 'pi_mock_${DateTime.now().millisecondsSinceEpoch}',
    'amount': (amount * 100).toInt(), // cents
    'currency': currency.toLowerCase(),
    'status': 'requires_payment_method',
    'client_secret': 'pi_mock_secret_${DateTime.now().millisecondsSinceEpoch}',
  };

  static Map<String, dynamic> get successfulPayment => {
    'id': 'pi_mock_completed',
    'status': 'succeeded',
    'amount_received': 2500,
    'currency': 'usd',
  };
}
