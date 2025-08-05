import 'package:flex_travel_sim/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/confirm_remote_data_source.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/firebase_auth_data_source.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/otp_auth_data_source.dart';
import 'package:flex_travel_sim/features/auth/data/repo/auth_repository_impl.dart';
import 'package:flex_travel_sim/features/auth/data/repo/firebase_auth_repository_impl.dart';
import 'package:flex_travel_sim/features/auth/domain/repo/auth_repository.dart';
import 'package:flex_travel_sim/features/auth/domain/use_cases/confirm_use_case.dart';
import 'package:flex_travel_sim/features/auth/domain/use_cases/firebase_login_use_case.dart';
import 'package:flex_travel_sim/features/auth/domain/use_cases/send_password_reset_use_case.dart';
import 'package:flex_travel_sim/features/auth/presentation/bloc/otp_auth_bloc.dart';
import 'package:flex_travel_sim/core/network/api_client.dart';
import 'package:flex_travel_sim/core/network/travel_sim_api_service.dart';
import 'package:flex_travel_sim/core/storage/local_storage.dart';
import 'package:flex_travel_sim/features/esim_management/data/data_sources/esim_local_data_source.dart';
import 'package:flex_travel_sim/features/esim_management/data/data_sources/esim_remote_data_source.dart';
import 'package:flex_travel_sim/features/esim_management/data/repositories/esim_repository_impl.dart';
import 'package:flex_travel_sim/features/esim_management/domain/repositories/esim_repository.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/activate_esim_use_case.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/get_esims_use_case.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/purchase_esim_use_case.dart';
import 'package:flex_travel_sim/features/user_account/data/data_sources/user_local_data_source.dart';
import 'package:flex_travel_sim/features/user_account/data/data_sources/user_remote_data_source.dart';
import 'package:flex_travel_sim/features/user_account/data/repositories/user_repository_impl.dart';
import 'package:flex_travel_sim/features/user_account/domain/repositories/user_repository.dart';
import 'package:flex_travel_sim/features/user_account/domain/use_cases/get_current_user_use_case.dart';
import 'package:flex_travel_sim/features/user_account/domain/use_cases/update_user_profile_use_case.dart';
import 'package:flex_travel_sim/features/onboarding/bloc/welcome_bloc.dart';
import 'package:flex_travel_sim/features/subscriber/data/data_sources/subscriber_remote_data_source.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<Type, dynamic> _services = {};
  bool _isInitialized = false;

  T get<T>() {
    final service = _services[T];
    if (service == null) {
      throw Exception('Service of type $T is not registered');
    }
    return service as T;
  }

  void register<T>(T service) {
    _services[T] = service;
  }

  void registerLazySingleton<T>(T Function() factory) {
    _services[T] = factory;
  }

  void registerFactory<T>(T Function() factory) {
    _services[T] = factory;
  }

  Future<void> init() async {
    if (_isInitialized) return;

    // Core dependencies
    await _initCore();

    // Feature dependencies
    await _initEsimManagement();
    await _initUserAccount();
    await _initAuth();
    await _initTariffsAndCountries();
    await _initOnboarding();
    await _initSubscriber();

    _isInitialized = true;
  }

  Future<void> _initCore() async {
    // HTTP Client
    register<http.Client>(http.Client());

    // Travel SIM API Client (primary API)
    final travelSimApiClient = ApiClient(
      baseUrl: dotenv.env['API_URL']!,
      client: get<http.Client>(),
    );
    if (kDebugMode) {
      print('Travel SIM API URL: ${dotenv.env['API_URL']}');
    }

    final legacyApiClient = ApiClient(
      baseUrl: dotenv.env['API_URL']!,
      client: get<http.Client>(),
    );

    register<ApiClient>(legacyApiClient);

    // Travel SIM API Service
    register<TravelSimApiService>(
      TravelSimApiService(apiClient: travelSimApiClient),
    );

    // Local Storage
    register<LocalStorage>(SharedPreferencesStorage());
  }

  Future<void> _initAuth() async {
    // DataSources

    register<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(apiClient: get<ApiClient>()),
    );

    register<AuthLocalDataSource>(
      AuthLocalDataSourceImpl(localStorage: get<LocalStorage>()),
    );

    register<ConfirmRemoteDataSource>(
      ConfirmRemoteDataSourceImpl(apiClient: get<ApiClient>()),
    );

    register<FirebaseAuthDataSource>(FirebaseAuthDataSourceImpl());

    register<OtpAuthDataSource>(
      OtpAuthDataSourceImpl(travelSimApiService: get<TravelSimApiService>()),
    );

    // Repositories

    register<AuthRepository>(
      AuthRepositoryImpl(
        remoteDataSource: get<AuthRemoteDataSource>(),
        localDataSource: get<AuthLocalDataSource>(),
        confirmRemoteDataSource: get<ConfirmRemoteDataSource>(),
      ),
    );

    register<FirebaseAuthRepositoryImpl>(
      FirebaseAuthRepositoryImpl(
        firebaseDataSource: get<FirebaseAuthDataSource>(),
        localDataSource: get<AuthLocalDataSource>(),
      ),
    );

    // Use Cases

    register<ConfirmUseCase>(ConfirmUseCase(repository: get<AuthRepository>()));

    register<FirebaseLoginUseCase>(
      FirebaseLoginUseCase(repository: get<FirebaseAuthRepositoryImpl>()),
    );

    register<SendPasswordResetUseCase>(
      SendPasswordResetUseCase(get<FirebaseAuthRepositoryImpl>()),
    );

    // Blocs

    register<OtpAuthBloc>(
      OtpAuthBloc(otpAuthDataSource: get<OtpAuthDataSource>()),
    );
  }

  Future<void> _initEsimManagement() async {
    // Data Sources
    register<EsimRemoteDataSource>(
      EsimRemoteDataSourceImpl(apiClient: get<ApiClient>()),
    );

    register<EsimLocalDataSource>(
      EsimLocalDataSourceImpl(localStorage: get<LocalStorage>()),
    );

    // Repository
    register<EsimRepository>(
      EsimRepositoryImpl(
        remoteDataSource: get<EsimRemoteDataSource>(),
        localDataSource: get<EsimLocalDataSource>(),
      ),
    );

    // Use Cases
    register<GetEsimsUseCase>(GetEsimsUseCase(get<EsimRepository>()));

    register<ActivateEsimUseCase>(ActivateEsimUseCase(get<EsimRepository>()));

    register<PurchaseEsimUseCase>(PurchaseEsimUseCase(get<EsimRepository>()));
  }

  Future<void> _initUserAccount() async {
    // Data Sources
    register<UserRemoteDataSource>(
      UserRemoteDataSourceImpl(apiClient: get<ApiClient>()),
    );

    register<UserLocalDataSource>(
      UserLocalDataSourceImpl(localStorage: get<LocalStorage>()),
    );

    // Repository
    register<UserRepository>(
      UserRepositoryImpl(
        remoteDataSource: get<UserRemoteDataSource>(),
        localDataSource: get<UserLocalDataSource>(),
      ),
    );

    // Use Cases
    register<GetCurrentUserUseCase>(
      GetCurrentUserUseCase(get<UserRepository>()),
    );

    register<UpdateUserProfileUseCase>(
      UpdateUserProfileUseCase(get<UserRepository>()),
    );
  }

  Future<void> _initTariffsAndCountries() async {
    // TODO: Implement tariffs and countries dependencies
  }

  Future<void> _initOnboarding() async {
    // Onboarding Bloc
    register<WelcomeBloc>(WelcomeBloc());
  }

  Future<void> _initSubscriber() async {
    // Data Sources
    register<SubscriberRemoteDataSource>(
      SubscriberRemoteDataSourceImpl(
        travelSimApiService: get<TravelSimApiService>(),
      ),
    );

    // Blocs
    register<SubscriberBloc>(
      SubscriberBloc(
        subscriberRemoteDataSource: get<SubscriberRemoteDataSource>(),
      ),
    );
  }

  void reset() {
    _services.clear();
    _isInitialized = false;
  }

  void dispose() {
    // Dispose any services that need cleanup
    final apiClient = _services[ApiClient];
    if (apiClient != null) {
      (apiClient as ApiClient).dispose();
    }

    final httpClient = _services[http.Client];
    if (httpClient != null) {
      (httpClient as http.Client).close();
    }

    reset();
  }
}

// Global service locator instance
final sl = ServiceLocator();
