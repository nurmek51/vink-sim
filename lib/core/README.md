# Data Layer Architecture

Этот документ описывает архитектуру Data Layer, реализованную в проекте FlexTravelSIM.

## Структура

```
lib/
├── core/
│   ├── di/               # Dependency Injection
│   ├── error/            # Обработка ошибок
│   ├── network/          # HTTP клиент
│   └── storage/          # Локальное хранилище
├── features/
│   └── feature_name/
│       ├── data/
│       │   ├── models/           # Модели данных
│       │   ├── data_sources/     # Источники данных
│       │   └── repositories/     # Реализации репозиториев
│       ├── domain/
│       │   ├── entities/         # Бизнес-сущности
│       │   ├── repositories/     # Интерфейсы репозиториев
│       │   └── use_cases/        # Варианты использования
│       └── presentation/
│           ├── bloc/             # BLoC/Cubit
│           ├── pages/            # Экраны
│           └── widgets/          # Виджеты
```

## 🔧 Основные компоненты

### 1. Core Layer

#### ApiClient
HTTP клиент для взаимодействия с API:
```dart
final apiClient = ApiClient(baseUrl: 'https://api.example.com');
final response = await apiClient.get('/users');
```

#### LocalStorage
Абстракция для локального хранилища:
```dart
final storage = SharedPreferencesStorage();
await storage.setJson('user', userModel.toJson());
final userJson = await storage.getJson('user');
```

#### Error Handling
Централизованная обработка ошибок:
```dart
// Exceptions
throw ServerException('Server error');
throw NetworkException('No internet connection');

// Failures
return Left(ServerFailure('Server error'));
return Right(data);
```

### 2. Data Sources

#### Remote Data Source
Взаимодействие с внешним API:
```dart
abstract class EsimRemoteDataSource {
  Future<List<EsimModel>> getEsims();
  Future<EsimModel> activateEsim(String id, String code);
}
```

#### Local Data Source
Работа с локальным кэшем:
```dart
abstract class EsimLocalDataSource {
  Future<List<EsimModel>> getCachedEsims();
  Future<void> cacheEsims(List<EsimModel> esims);
}
```

### 3. Repository Pattern

Репозитории объединяют remote и local data sources:
```dart
class EsimRepositoryImpl implements EsimRepository {
  final EsimRemoteDataSource remoteDataSource;
  final EsimLocalDataSource localDataSource;

  Future<Either<Failure, List<Esim>>> getEsims({bool forceRefresh = false}) async {
    try {
      // Попытка получить из кэша
      if (!forceRefresh) {
        final cached = await localDataSource.getCachedEsims();
        if (cached.isNotEmpty) {
          return Right(cached.map((e) => e.toEntity()).toList());
        }
      }

      // Получение с сервера
      final esims = await remoteDataSource.getEsims();
      await localDataSource.cacheEsims(esims);
      
      return Right(esims.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
```

### 4. Use Cases

Инкапсулируют бизнес-логику:
```dart
class GetEsimsUseCase {
  final EsimRepository repository;

  GetEsimsUseCase(this.repository);

  Future<Either<Failure, List<Esim>>> call({bool forceRefresh = false}) {
    return repository.getEsims(forceRefresh: forceRefresh);
  }
}
```

### 5. Dependency Injection

Управление зависимостями через ServiceLocator:
```dart
// Инициализация
await sl.init();

// Регистрация
sl.register<EsimRepository>(EsimRepositoryImpl(
  remoteDataSource: sl(),
  localDataSource: sl(),
));

// Использование
final repository = sl.get<EsimRepository>();
```

## 🚀 Использование в BLoC

```dart
class EsimBloc extends Bloc<EsimEvent, EsimState> {
  final GetEsimsUseCase getEsimsUseCase;

  EsimBloc({required this.getEsimsUseCase}) : super(EsimInitial()) {
    on<LoadEsimsEvent>(_onLoadEsims);
  }

  Future<void> _onLoadEsims(LoadEsimsEvent event, Emitter<EsimState> emit) async {
    emit(EsimLoading());

    final result = await getEsimsUseCase(forceRefresh: event.forceRefresh);

    result.fold(
      (failure) => emit(EsimError(failure.message)),
      (esims) => emit(EsimLoaded(esims)),
    );
  }
}
```

## Преимущества

1. **Разделение ответственности** - каждый слой имеет четко определенную роль
2. **Тестируемость** - легко мокировать зависимости
3. **Кэширование** - автоматическое управление локальным кэшем
4. **Обработка ошибок** - централизованная система ошибок
5. **Offline-first** - работа без интернета с кэшированными данными
6. **Масштабируемость** - легко добавлять новые features

## Жизненный цикл данных

1. **UI событие** → BLoC вызывает Use Case
2. **Use Case** → вызывает Repository
3. **Repository** → проверяет Local Data Source
4. **Если данных нет** → обращается к Remote Data Source
5. **Получение данных** → кэширует в Local Data Source
6. **Преобразование** → Model → Entity
7. **Возврат результата** → через Either<Failure, Success>
8. **UI обновление** → BLoC эмитит новое состояние

## Добавление нового feature

1. Создать entity в `domain/entities/`
2. Создать model в `data/models/`
3. Создать data sources в `data/data_sources/`
4. Создать repository interface в `domain/repositories/`
5. Реализовать repository в `data/repositories/`
6. Создать use cases в `domain/use_cases/`
7. Зарегистрировать в DI контейнере
8. Создать BLoC в `presentation/bloc/`
9. Использовать в UI

## Дополнительные ресурсы

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Repository Pattern](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/infrastructure-persistence-layer-design)
- [BLoC Pattern](https://bloclibrary.dev/#/architecture)
