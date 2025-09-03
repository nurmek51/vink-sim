import 'package:get_it/get_it.dart';
import 'package:flex_travel_sim/core/services/configuration_service.dart';
import 'package:flex_travel_sim/core/services/auth_service.dart';
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
import 'package:flex_travel_sim/core/network/auth_interceptor.dart';
import 'package:flex_travel_sim/core/network/travel_sim_api_service.dart';
import 'package:flex_travel_sim/core/storage/local_storage.dart';
import 'package:flex_travel_sim/features/esim_management/data/data_sources/esim_local_data_source.dart';
import 'package:flex_travel_sim/features/esim_management/data/data_sources/esim_remote_data_source.dart';
import 'package:flex_travel_sim/features/esim_management/data/repositories/esim_repository_impl.dart';
import 'package:flex_travel_sim/features/esim_management/domain/repositories/esim_repository.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/activate_esim_use_case.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/get_esims_use_case.dart';
import 'package:flex_travel_sim/features/esim_management/domain/use_cases/purchase_esim_use_case.dart';
import 'package:flex_travel_sim/features/stripe_payment/presentation/bloc/stripe_bloc.dart';
import 'package:flex_travel_sim/features/stripe_payment/services/stripe_service.dart';
import 'package:flex_travel_sim/features/subscriber/data/data_sources/subscriber_local_data_source.dart';
import 'package:flex_travel_sim/features/user_account/data/data_sources/user_local_data_source.dart';
import 'package:flex_travel_sim/features/user_account/data/data_sources/user_remote_data_source.dart';
import 'package:flex_travel_sim/features/user_account/data/repositories/user_repository_impl.dart';
import 'package:flex_travel_sim/features/user_account/domain/repositories/user_repository.dart';
import 'package:flex_travel_sim/features/user_account/domain/use_cases/get_current_user_use_case.dart';
import 'package:flex_travel_sim/features/user_account/domain/use_cases/update_user_profile_use_case.dart';
import 'package:flex_travel_sim/features/onboarding/bloc/welcome_bloc.dart';
import 'package:flex_travel_sim/features/subscriber/data/data_sources/subscriber_remote_data_source.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:flex_travel_sim/core/services/token_manager.dart';
import 'package:http/http.dart' as http;

final GetIt sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    await _initCore();
    await _initAuth();
    await _initEsimManagement();
    await _initUserAccount();
    await _initSubscriber();
    await _initStripeService();
    await _initOnboarding();
  }

  static Future<void> _initCore() async {
    // Configuration Service
    sl.registerSingleton<ConfigurationService>(
      EnvironmentConfigurationService(),
    );

    // HTTP Client
    sl.registerSingleton<http.Client>(http.Client());

    // Local Storage
    sl.registerSingleton<LocalStorage>(SharedPreferencesStorage());

    // Auth Service
    sl.registerLazySingleton<AuthService>(
      () => AuthServiceImpl(localStorage: sl<LocalStorage>()),
    );

    // Auth Local Data Source
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(localStorage: sl<LocalStorage>()),
    );

    // Token Manager
    sl.registerLazySingleton<TokenManager>(
      () => TokenManager(authLocalDataSource: sl<AuthLocalDataSource>()),
    );

    // Auth Interceptor
    sl.registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(tokenManager: sl<TokenManager>()),
    );

    // API Clients
    sl.registerLazySingleton<ApiClient>(
      () => ApiClient(
        baseUrl: sl<ConfigurationService>().apiUrl,
        client: sl<http.Client>(),
      ),
    );

    // Travel SIM API Service with auth interceptor
    sl.registerLazySingleton<TravelSimApiService>(() {
      final apiClient = ApiClient(
        baseUrl: sl<ConfigurationService>().apiUrl,
        authInterceptor: sl<AuthInterceptor>(),
        client: sl<http.Client>(),
      );
      return TravelSimApiService(apiClient: apiClient);
    });
  }

  static Future<void> _initAuth() async {
    // Data Sources
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
    );

    sl.registerLazySingleton<ConfirmRemoteDataSource>(
      () => ConfirmRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
    );

    sl.registerLazySingleton<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSourceImpl(),
    );

    sl.registerLazySingleton<OtpAuthDataSource>(
      () =>
          OtpAuthDataSourceImpl(travelSimApiService: sl<TravelSimApiService>()),
    );

    // Repositories
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl<AuthRemoteDataSource>(),
        localDataSource: sl<AuthLocalDataSource>(),
        confirmRemoteDataSource: sl<ConfirmRemoteDataSource>(),
      ),
    );

    sl.registerLazySingleton<FirebaseAuthRepositoryImpl>(
      () => FirebaseAuthRepositoryImpl(
        firebaseDataSource: sl<FirebaseAuthDataSource>(),
        localDataSource: sl<AuthLocalDataSource>(),
      ),
    );

    // Use Cases
    sl.registerLazySingleton<ConfirmUseCase>(
      () => ConfirmUseCase(repository: sl<AuthRepository>()),
    );

    sl.registerLazySingleton<FirebaseLoginUseCase>(
      () => FirebaseLoginUseCase(repository: sl<FirebaseAuthRepositoryImpl>()),
    );

    sl.registerLazySingleton<SendPasswordResetUseCase>(
      () => SendPasswordResetUseCase(sl<FirebaseAuthRepositoryImpl>()),
    );

    // Blocs
    sl.registerFactory<OtpAuthBloc>(
      () => OtpAuthBloc(
        otpAuthDataSource: sl<OtpAuthDataSource>(),
        firebaseLoginUseCase: sl<FirebaseLoginUseCase>(),
      ),
    );
  }

  static Future<void> _initEsimManagement() async {
    // Data Sources
    sl.registerLazySingleton<EsimRemoteDataSource>(
      () => EsimRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
    );

    sl.registerLazySingleton<EsimLocalDataSource>(
      () => EsimLocalDataSourceImpl(localStorage: sl<LocalStorage>()),
    );

    // Repository
    sl.registerLazySingleton<EsimRepository>(
      () => EsimRepositoryImpl(
        remoteDataSource: sl<EsimRemoteDataSource>(),
        localDataSource: sl<EsimLocalDataSource>(),
      ),
    );

    // Use Cases
    sl.registerLazySingleton<GetEsimsUseCase>(
      () => GetEsimsUseCase(sl<EsimRepository>()),
    );

    sl.registerLazySingleton<ActivateEsimUseCase>(
      () => ActivateEsimUseCase(sl<EsimRepository>()),
    );

    sl.registerLazySingleton<PurchaseEsimUseCase>(
      () => PurchaseEsimUseCase(sl<EsimRepository>()),
    );
  }

  static Future<void> _initUserAccount() async {
    // Data Sources
    sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
    );

    sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(localStorage: sl<LocalStorage>()),
    );

    // Repository
    sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        remoteDataSource: sl<UserRemoteDataSource>(),
        localDataSource: sl<UserLocalDataSource>(),
      ),
    );

    // Use Cases
    sl.registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(sl<UserRepository>()),
    );

    sl.registerLazySingleton<UpdateUserProfileUseCase>(
      () => UpdateUserProfileUseCase(sl<UserRepository>()),
    );
  }


  static Future<void> _initOnboarding() async {
    // Onboarding Bloc
    sl.registerFactory<WelcomeBloc>(() => WelcomeBloc());
  }

  static Future<void> _initSubscriber() async {
    // Data Sources
    sl.registerLazySingleton<SubscriberRemoteDataSource>(
      () => SubscriberRemoteDataSourceImpl(
        travelSimApiService: sl<TravelSimApiService>(),
      ),
    );

    sl.registerLazySingleton<SubscriberLocalDataSource>(
      () => SubscriberLocalDataSourceImpl(localStorage: sl<LocalStorage>()),
    );

    // Blocs
    sl.registerFactory<SubscriberBloc>(
      () => SubscriberBloc(
        subscriberRemoteDataSource: sl<SubscriberRemoteDataSource>(),
      ),
    );
  }

  static Future<void> _initStripeService() async {
    sl.registerLazySingleton<StripeService>(
      () => StripeService(sl<FirebaseLoginUseCase>()),
    );

    sl.registerFactory<StripeBloc>(
      () => StripeBloc(stripeService: sl<StripeService>()),
    );
  }

  static Future<void> reset() async {
    await sl.reset();
  }

  static Future<void> dispose() async {
    // Dispose any services that need cleanup
    if (sl.isRegistered<TokenManager>()) {
      sl<TokenManager>().dispose();
    }

    if (sl.isRegistered<AuthInterceptor>()) {
      sl<AuthInterceptor>().dispose();
    }

    if (sl.isRegistered<ApiClient>()) {
      sl<ApiClient>().dispose();
    }

    if (sl.isRegistered<http.Client>()) {
      sl<http.Client>().close();
    }

    await reset();
  }
}
