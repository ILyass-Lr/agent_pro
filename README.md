# AgentPro Architecture Guide

**AgentPro** is an AI-driven football management platform that facilitates player-club matching, contract negotiation tracking, and automated communication. This project demonstrates modern Flutter development practices using **Clean Architecture**, **TDD**, **Functional Programming**, **Riverpod**, and **Drift** for local persistence.

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Clean Architecture Overview](#clean-architecture-overview)
3. [Layer Responsibilities](#layer-responsibilities)
4. [Functional Programming & Error Handling](#functional-programming--error-handling)
5. [Authentication & Authorization](#authentication--authorization)
6. [State Management with Riverpod](#state-management-with-riverpod)
7. [Local Persistence with Drift](#local-persistence-with-drift)
8. [Navigation with Go Router](#navigation-with-go-router)
9. [Network Connectivity](#network-connectivity)

---

## Getting Started

### Prerequisites

- **Dart SDK**: ^3.10.7
- **Flutter**: Latest stable version
- **Git**: For version control

### Installation & Setup

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd agent_pro
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code files** (Riverpod, Freezed, Drift, JSON serialization)

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**

   ```bash
   flutter run
   ```

   Or to run on a specific device/emulator:

   ```bash
   flutter run -d <device-id>
   ```

### Development Workflow

**Watch mode** (auto-regenerate code on save):

```bash
dart run build_runner watch --delete-conflicting-outputs
```

**Run tests**:

```bash
flutter test
```

**Build APK** (Android):

```bash
flutter build apk --release
```

**Build IPA** (iOS):

```bash
flutter build ios --release
```

---

## Clean Architecture Overview

This project implements **Clean Architecture** to ensure:

- ✅ Separation of concerns
- ✅ Testability through dependency injection
- ✅ Reusability of business logic
- ✅ Independence from external frameworks
- ✅ Easy maintenance and scalability

### Architecture Layers

```
┌─────────────────────────────────────────────┐
│           PRESENTATION LAYER                │
│   (UI, Controllers, State Management)       │
├─────────────────────────────────────────────┤
│           DOMAIN LAYER                      │
│   (Entities, Repositories (Abstract),       │
│    Use Cases)                               │
├─────────────────────────────────────────────┤
│           DATA LAYER                        │
│   (Repositories (Implementation),           │
│    Data Sources, Models)                    │
├─────────────────────────────────────────────┤
│           CORE LAYER                        │
│   (Error Handling, Network, Database,       │
│    Routing, DI Container)                   │
└─────────────────────────────────────────────┘
```

---

## Layer Responsibilities

### 1. **Presentation Layer** (`lib/features/*/presentation/`)

**Responsibility**: Handle UI rendering and user interaction.

**Components**:

- **Pages**: Full-screen widgets (e.g., `SignInForm`, `OnboardingScreen`)
- **Widgets**: Reusable UI components (e.g., `CustomBanner`, `AuthText`)
- **Controllers**: Manage mutations and orchestrate business logic
  - Example: [AuthController](lib/features/auth/presentation/controllers/auth_controller.dart)
  - Uses **Riverpod Mutations** for asynchronous operations
  - Handles error display and navigation side effects

**Key Characteristics**:

- Depends on the **Domain Layer** only (use cases, repositories)
- Uses **Riverpod** for state management
- Implements **listeners** to react to mutation state changes
- Never directly calls repositories or data sources

**Example Flow**:

```dart
// In a form widget, listen to mutation state
final signUpMutation = ref.watch(signUpMutationProvider);

ref.listen(signUpMutation, (previous, next) {
  if (next is MutationSuccess) {
    // Navigate on success
    context.go('/sign-in');
  } else if (next is MutationError) {
    // Display error message
    ScaffoldMessenger.of(context).showSnackBar(...);
  }
});
```

### 2. **Domain Layer** (`lib/features/*/domain/`)

**Responsibility**: Contain business logic and define contracts (abstract repositories).

**Components**:

- **Entities**: Pure Dart classes representing core business objects
  - Example: `Agent`, `Player`
  - No framework dependencies (no `@freezed`, `@JsonSerializable`, etc.)
- **Repositories (Abstract Interfaces)**: Define contracts for data access
  - Example: [AuthRepository](lib/features/auth/domain/repositories/auth_repository.dart)
  - Return `Either<Failure, T>` for functional error handling (see [Functional Programming](#functional-programming--error-handling))
- **Use Cases**: Encapsulate a single business rule or workflow
  - Example: [DeletePlayer](lib/features/players/domain/usecases/delete_player_use_case.dart)
  - Inherit from `UseCase<T, Params>` abstract class
  - Provide a single `call()` method that returns `FutureOr<Either<Failure, T>>`
  - Keep them focused and testable

**Key Characteristics**:

- **No framework dependencies** (no Riverpod, Dio, etc.)
- Pure Dart classes
- Highly testable with minimal mocking
- Independent of UI and database implementations

**Example Use Case**:

```dart
class DeletePlayer extends UseCase<void, String> {
  final PlayerRepository repository;

  DeletePlayer(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deletePlayer(id);
  }
}
```

### 3. **Data Layer** (`lib/features/*/data/`)

**Responsibility**: Implement repositories and manage data sources (remote API, local database, cache).

**Components**:

- **Repositories (Implementation)**: Implement abstract repository interfaces
  - Example: [AuthRepositoryImpl](lib/features/auth/data/repositories/auth_repository_implementation.dart)
  - Handle **network-first with fallback strategy**:
    - Try remote data source first
    - Fall back to local cache if offline
  - Convert exceptions to Failures
  - Provided via Riverpod
- **Data Sources**:
  - **Remote**: API calls via Dio (REST)
    - Example: `AuthRemoteDataSource` calls `/sign-in`, `/sign-up` endpoints
  - **Local**: Database and storage (Drift, SharedPreferences, SecureStorage)
    - Example: `AuthLocalDataSource` caches tokens and user data
- **Models**: Data transfer objects with serialization
  - Use `@Freezed` and `@JsonSerializable` for type safety
  - Convert to domain entities before returning to domain layer

**Key Characteristics**:

- Depends on the **Domain Layer** (repositories and entities)
- Handles all framework-specific logic (Dio, Drift, SharedPreferences)
- Maps external data formats (JSON) to domain entities
- Manages error conversion (Server exceptions → Failures)

**Example Repository**:

```dart
@override
Future<Either<Failure, Agent>> signIn({
  required String email,
  required String password,
  bool rememberMe = false,
}) async {
  // Check network first
  if (await networkInfo.isConnected) {
    try {
      // Call remote API
      final authResponse = await remoteDataSource.signIn(
        email: email,
        password: password,
      );
      // Save tokens if Remember Me enabled
      if (rememberMe) {
        await localDataSource.saveTokens(
          authResponse.tokens.accessToken,
          authResponse.tokens.refreshToken,
        );
      }
      // Map response to domain entity
      return Right(authResponse.agent.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, field: e.field));
    }
  } else {
    return const Left(NetworkFailure());
  }
}
```

### 4. **Core Layer** (`lib/core/`)

**Responsibility**: Provide shared utilities, error handling, network, routing, and DI container.

**Sub-directories**:

- **`error/`**: Failure classes and exception definitions
  - `Failure`: Sealed union type representing all possible errors
  - `Exceptions`: Thrown by data sources, converted to Failures by repositories
- **`network/`**: Network and API configuration
  - `DioClient`: HTTP client with interceptors
  - `AuthInterceptor`: Handles token refresh and `requireAuth` field
  - `NetworkInfo`: Checks internet connectivity
  - `TokenRefresher`: Manages token refresh logic
- **`database/`**: Drift database setup and providers
  - `AppDatabase`: Main database instance
  - `KeyValueStore`: Generic key-value table for caching
- **`router/`**: Navigation setup with Go Router
- **`storage/`**: Token storage and session management
- **`services/`**: App-wide services (auth status, app settings)
- **`usecase/`**: Base `UseCase` class for all use cases
- **`types/`**: Shared types and type aliases
- **`widgets/`**: Shared UI components

**Key Characteristics**:

- Provides **dependency injection** through Riverpod providers
- Centralizes error handling
- Frame-agnostic (though some utilities are Flutter-specific)

---

## Functional Programming & Error Handling

AgentPro uses **functional error handling** via [`fpdart`](https://github.com/SandroMaglione/fpdart) to eliminate exceptions and null checks.

### The `Either<L, R>` Type

`Either<Failure, Success>` represents a result that is either a **Failure** (left) or a **Success** (right):

```dart
Either<Failure, Agent> result = ...;

// Match and handle both cases:
result.fold(
  (failure) => // Handle failure
  (agent) => // Handle success
);
```

### Failure Types

All failures are defined in [core/error/failure.dart](lib/core/error/failure.dart):

```dart
@freezed
sealed class Failure with _$Failure {
  // Network and data layer failures
  const factory Failure.serverFailure({
    @Default('A server error occured') String message,
    SignUpField? field,
  }) = ServerFailure;

  const factory Failure.unauthorizedFailure({
    @Default('Unauthorized access') String message,
    required String reason,
    @Default(Status.pending) Status status,
  }) = UnauthorizedFailure;

  const factory Failure.cacheFailure({
    @Default('No cached data found') String message,
  }) = CacheFailure;

  const factory Failure.networkFailure({
    @Default('Please check your internet connection') String message,
  }) = NetworkFailure;

  // Presentation layer failures
  const factory Failure.invalidInputFailure({
    @Default('Invalid input') String message,
  }) = InvalidInputFailure;

  const factory Failure.rateLimitFailure({
    @Default('Too many requests') String message,
    @Default(60) int coolDownSeconds,
  }) = RateLimitFailure;
}
```

### Use Case Pattern with Either

All use cases return `Either<Failure, T>`:

```dart
// In repository
@override
Future<Either<Failure, Agent>> signIn({...}) async {
  if (await networkInfo.isConnected) {
    try {
      final agent = await remoteDataSource.signIn(...);
      return Right(agent); // Success
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message)); // Failure
    }
  } else {
    return const Left(NetworkFailure()); // No internet
  }
}

// In controller
Future<Agent> performSignIn() async {
  return await mutation.run(ref, (tsx) async {
    final signIn = tsx.get(signInUseCaseProvider);
    final result = await signIn((email: state.email, password: state.password));
    return result.fold(
      (failure) => throw failure, // Convert to exception for Mutation
      (agent) {
        ref.read(authStatusProvider.notifier).login(agent);
        return agent;
      },
    );
  });
}
```

### Error Handling in UI

The mutation state includes error information:

```dart
final signInMutation = ref.watch(signInMutationProvider);
final error = signInMutation is MutationError
    ? (signInMutation as MutationError).error as Failure
    : null;

// Display error based on type
if (error is ServerFailure) {
  // Show server error message
  showErrorBanner("Server error: ${error.message}");
} else if (error is NetworkFailure) {
  // Show network error message
  showErrorBanner("Network error: ${error.message}");
} else if (error is RateLimitFailure) {
  // Show rate-limit specific UI
  showCountdown(error.coolDownSeconds);
}
```

### Benefits of This Approach

✅ **Explicit error handling**: No surprises with exceptions  
✅ **Type-safe**: Compiler enforces handling all error types  
✅ **Composable**: Chain operations with functional operators  
✅ **Testable**: Mock failures easily in unit tests  
✅ **No null checking**: `Either` is always defined

---

## Authentication & Authorization

### Architecture

The authentication system is built into the **data layer** with interceptor-level token management:

```
┌─────────────────────────────────┐
│   Presentation (Sign In Form)   │
└──────────────┬──────────────────┘
               │ mutation.run()
┌──────────────▼──────────────────┐
│  Auth Controller (Riverpod)     │
│  - performSignIn()              │
│  - performSignUp()              │
│  - performSignOut()             │
└──────────────┬──────────────────┘
               │ calls use case
┌──────────────▼──────────────────┐
│  Use Cases (Domain)             │
└──────────────┬──────────────────┘
               │ calls repository
┌──────────────▼──────────────────┐
│  AuthRepository (Data)          │
│  - signIn()                     │
│  - signUp()                     │
│  - signOut()                    │
└──────────────┬──────────────────┘
               │
    ┌──────────┴──────────┐
    │                     │
┌───▼─────────────┐  ┌────▼──────────────┐
│  Remote API     │  │  Local Storage    │
│  (with tokens)  │  │  (tokens, cache)  │
└─────────────────┘  └───────────────────┘
```

### Auth Interceptor

The [AuthInterceptor](lib/core/network/auth_interceptor.dart) automatically handles:

1. **Token Injection (Request)**:
   - Checks RAM (SessionProvider) for access token
   - Falls back to disk (TokenStorage) if RAM is empty
   - Attaches token to `Authorization` header (unless `requireAuth: false`)

   ```dart
   @override
   Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
     // 1. Check RAM
     String? accessToken = read(sessionProvider);

     // 2. If RAM is empty, hydrate from disk
     if (accessToken == null) {
       accessToken = await tokenStorage.getAccessToken();
       if (accessToken != null) {
         read(sessionProvider.notifier).setToken(accessToken);
       }
     }

     // 3. Attach to request (unless requireAuth: false)
     if (accessToken != null && options.extra['requireAuth'] != false) {
       options.headers['Authorization'] = 'Bearer $accessToken';
     }

     handler.next(options);
   }
   ```

2. **Token Refresh (Error Response on 401)**:
   - Intercepts 401 Unauthorized responses
   - Attempts to refresh the token using the refresh token
   - Retries the original request with the new token
   - Clears tokens and logs out if refresh fails

   ```dart
   @override
   Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
     // Is this a 401 (unauthorized)?
     if (err.response?.statusCode == 401 && !err.requestOptions.path.contains('/refresh')) {
       try {
         // Prevent simultaneous refresh attempts
         final newAccessToken = await (_refreshFuture ??= _performRefresh());
         if (newAccessToken != null) {
           // Retry original request with new token
           final options = err.requestOptions;
           options.headers['Authorization'] = 'Bearer $newAccessToken';
           final response = await dio.fetch(options);
           return handler.resolve(response);
         } else {
           _handleLogout();
         }
       } catch (e) {
         _handleLogout();
       } finally {
         _refreshFuture = null;
       }
     }
     handler.next(err);
   }
   ```

### The `requireAuth` Field

Some API endpoints can be called without authentication (e.g., `/sign-in`, `/sign-up`, `/refresh-token`).

Set `requireAuth: false` in request options to skip token attachment:

```dart
// In data source
final response = await dio.post(
  '/sign-in',
  data: {...},
  options: Options(
    extra: {'requireAuth': false}, // Skip token injection
  ),
);

// Token will NOT be attached to this request
```

**Default behavior** (if `requireAuth` is not specified or is `null`):

- Token IS attached if available
- This is the correct behavior for most authenticated endpoints

### Session Management

The session is stored in two places:

1. **RAM (SessionProvider - Riverpod)**:
   - Fast, volatile access
   - Lost when app is closed or hot-restarted

2. **Disk (TokenStorage)**:
   - Persistent using `flutter_secure_storage`
   - Used to hydrate RAM on app startup
   - Cleared on logout

**Startup Flow**:

```dart
@riverpod
Future<void> appStartup(Ref ref) async {
  // Initialize storage
  await ref.watch(sharedPreferencesProvider.future);

  // Initialize auth state from disk
  await ref.watch(authInitProvider.future);
  // This attempts to restore session from TokenStorage
  // If successful, user is logged in automatically
}
```

### Auth Status Notifier

The [AuthStatusNotifier](lib/features/auth/presentation/controllers/auth_controller.dart) maintains the global auth state:

```dart
@riverpod
class AuthStatus extends _$AuthStatus {
  @override
  AuthState build() => const AuthState.initial();

  void login(Agent agent) => state = AuthState.authenticated(agent);
  void logout() => state = AuthState.unauthenticated();
  void block(String message, String reason) =>
    state = AuthState.blocked(message, reason);
}
```

**Auth State Types**:

- `AuthState.initial()`: App just started, checking stored session
- `AuthState.authenticated(agent)`: User is logged in
- `AuthState.unauthenticated()`: User logged out or auth failed
- `AuthState.blocked(message, reason)`: User account is blocked

---

## State Management with Riverpod

AgentPro uses **Riverpod** for dependency injection and state management, with the new **Mutation** experimental feature for handling side effects.

### Provider Types

**1. Functional Providers** (Read-only, computed):

```dart
@riverpod
NetworkInfo networkInfo(Ref ref) {
  final connectivity = ref.watch(connectivityProvider);
  final internetConnection = ref.watch(internetConnectionProvider);
  return NetworkInfoImpl(connectivity, internetConnection);
}
```

**2. Family Providers** (Parameterized):

```dart
@riverpod
Future<Agent> fetchAgent(Ref ref, String agentId) async {
  final repository = ref.watch(authRepositoryProvider);
  return repository.getCurrentAgent(agentId);
}

// Usage:
ref.watch(fetchAgentProvider('agent-123'));
```

**3. Notifier Providers** (Stateful):

```dart
@riverpod
class SignUpNotifier extends _$SignUpNotifier {
  @override
  SignUpState build() => SignUpState.initial();

  void setFirstName(String name) => state = state.copyWith(firstName: name);
}
```

**4. Mutation Providers** (For side effects):

```dart
@riverpod
Mutation<Unit> signUpMutation(Ref ref) => Mutation<Unit>();

// Usage:
await mutation.run(ref, (tsx) async {
  final signUp = tsx.get(signUpUseCaseProvider);
  final result = await signUp(params);
  return result.fold(
    (failure) => throw failure,
    (_) => unit,
  );
});
```

### The Mutation Pattern (Experimental)

Mutations are ideal for **asynchronous operations with side effects** (API calls, form submissions).

**Key Features**:

- **State tracking**: `MutationPending`, `MutationSuccess<T>`, `MutationError`
- **Build context access via `tsx`**: Get dependencies using `tsx.get(provider)`
- **Error handling**: Exceptions thrown in mutation become `MutationError`
- **Cancellation**: Mutations are cancelled if provider is disposed

**Example: Sign In**

```dart
@riverpod
Mutation<Agent> signInMutation(Ref ref) => Mutation<Agent>();

// In controller:
Future<Agent> performSignIn() async {
  final state = ref.read(signInProvider);
  final mutation = ref.read(signInMutationProvider);

  return await mutation.run(ref, (tsx) async {
    final signIn = tsx.get(signInUseCaseProvider);
    final result = await signIn((
      email: state.email,
      password: state.password,
      rememberMe: state.rememberMe,
    ));
    return result.fold(
      (failure) {
        // Handle specific failures
        if (failure is UnauthorizedFailure) {
          ref.read(authStatusProvider.notifier).block(
            failure.message,
            failure.reason,
          );
        }
        throw failure; // Re-throw for MutationError state
      },
      (agent) {
        // Update auth status
        ref.read(authStatusProvider.notifier).login(agent);
        return agent;
      },
    );
  });
}
```

**In the UI**:

```dart
final signInMutation = ref.watch(signInMutationProvider);
final signInMutationState = ref.watch(signInMutation);

ref.listen(signInMutation, (previous, next) {
  if (next is MutationSuccess) {
    context.go('/home');
  }
});

// Show loading indicator
if (signInMutationState is MutationPending) {
  return CircularProgressIndicator();
}

// Show error banner
if (signInMutationState is MutationError) {
  final error = (signInMutationState as MutationError).error as Failure;
  return ErrorBanner(message: error.message);
}
```

### Dependency Injection (DI)

All dependencies are injectected via Riverpod providers:

```dart
// In data layer
@riverpod
AuthRepository authRepository(Ref ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    networkInfo: networkInfo,
    ref: ref,
  );
}

// In domain layer (use cases)
@riverpod
SignIn signInUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignIn(repository);
}

// In presentation layer (controller)
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  // Access use case via mutation.run(ref, (tsx) {
  //   final signIn = tsx.get(signInUseCaseProvider);
  // })
}
```

**Benefits**:
✅ **Testable**: Mock dependencies by overriding providers in tests  
✅ **Reusable**: Share dependencies across the app  
✅ **Decoupled**: No `new` keywords or constructor parameters

---

## Local Persistence with Drift

AgentPro uses **Drift** (formerly Moor) for local database management.

### Database Schema

The [AppDatabase](lib/core/database/app_database.dart) defines the database structure:

```dart
@DriftDatabase(tables: [KeyValueStore])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'agent_pro',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationDocumentsDirectory,
      ),
    );
  }
}
```

### Tables

**KeyValueStore** - Generic key-value storage:

```dart
class KeyValueStore extends Table {
  TextColumn get key => text()();           // Unique key
  TextColumn get value => text()();         // JSON value
  TextColumn get destroyKey => text().nullable()(); // For cascading deletes
  DateTimeColumn get expireAt => dateTime().nullable()(); // For TTL

  @override
  Set<Column> get primaryKey => {key};
}
```

### Usage Patterns

**Save data**:

```dart
await appDatabase.into(appDatabase.keyValueStore).insert(
  KeyValueStoreCompanion.insert(
    key: 'user_agent',
    value: jsonEncode(agent.toJson()),
  ),
);
```

**Read data**:

```dart
final stored = await (appDatabase.select(appDatabase.keyValueStore)
  ..where((t) => t.key.equals('user_agent')))
  .getSingleOrNull();

if (stored != null) {
  final agent = Agent.fromJson(jsonDecode(stored.value));
}
```

**Delete data**:

```dart
await (appDatabase.delete(appDatabase.keyValueStore)
  ..where((t) => t.key.equals('user_agent')))
  .go();
```

### Riverpod Integration

The database is provided via Riverpod for easy access:

```dart
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
}

// In data sources:
@override
Future<void> saveTokens(String accessToken, String refreshToken) async {
  final database = ref.watch(appDatabaseProvider);
  // Use database to persist tokens
}
```

### Migration Strategy

When you need to update the schema:

1. **Add a new table** to the database class
2. **Increment `schemaVersion`**:
   ```dart
   @override
   int get schemaVersion => 2; // was 1
   ```
3. **Add migration logic** (if data transformation is needed):
   ```dart
   @override
   MigrationStrategy get migration => MigrationStrategy(
     onCreate: (Migrator m) {
       return m.createAll();
     },
     onUpgrade: (Migrator m, int from, int to) async {
       // Handle migrations from v1 to v2, etc.
     },
   );
   ```

---

## Navigation with Go Router

AgentPro uses **Go Router** v17.1.0 for declarative, type-safe navigation.

### Router Setup

The [RouterProvider](lib/core/router/router_provider.dart) defines all routes:

```dart
@riverpod
GoRouter router(Ref ref) {
  final appSettings = ref.watch(appSettingServiceProvider);
  final authState = ref.watch(authStatusProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      // Handle navigation redirects based on auth state
    },
    routes: [
      // Route definitions
    ],
  );
}
```

### Route Structure

```
Home (/)
├── Onboarding (/onboarding)
├── Auth Routes (with AuthShell)
│   ├── Sign In (/sign-in)
│   ├── Sign Up Step 1 (/sign-up/step-1)
│   ├── Sign Up Step 2 (/sign-up/step-2)
│   ├── Forgot Password Step 1 (/forgot-password/step-1)
│   ├── Forgot Password Step 2 (/forgot-password/step-2)
│   └── Forgot Password Step 3 (/forgot-password/step-3)
└── Dashboard (/home)
```

### Key Features

**1. No-Transition Pages** (Smooth navigation):

```dart
NoTransitionPage<void> _noTransitionPage({
  required LocalKey key,
  required Widget child,
}) {
  return NoTransitionPage<void>(key: key, child: child);
}

GoRoute(
  path: '/sign-in',
  pageBuilder: (context, state) => _noTransitionPage(
    key: state.pageKey,  // ✅ IMPORTANT: Prevents element reparent errors
    child: SignInForm(),
  ),
),
```

**⚠️ IMPORTANT**: Always pass `key: state.pageKey` to `MaterialPage` or `NoTransitionPage`. This keeps the page identity stable during redirects/rebuilds and prevents "element reparent" assertion errors.

**2. Shell Routes** (Nested layouts):

```dart
ShellRoute(
  builder: (context, state, child) => AuthShell(
    currentPath: state.matchedLocation,
    child: child,
  ),
  routes: [
    GoRoute(path: '/sign-in', ...),
    GoRoute(path: '/sign-up/step-1', ...),
    // All routes share AuthShell as parent
  ],
),
```

**3. Redirection** (Auth gating):

```dart
redirect: (context, state) {
  final isFirstOpen = appSettings.isFirstOpen;
  final isAuthenticated = authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );
  final currentPath = state.matchedLocation;

  // Route to onboarding if first time
  if (currentPath == '/' && isFirstOpen) return '/onboarding';

  // Route unauthenticated users to sign-in
  if (!isAuthenticated && !isAuthRoute) return '/sign-in';

  // Prevent authenticated users from accessing auth routes
  if (isAuthenticated && isAuthRoute) return '/home';

  return null; // No redirection needed
},
```

### Navigation in Code

**Navigate to a route**:

```dart
context.go('/sign-in');

// With query parameters
context.go('/players?sort=name&filter=active');

// With extra data
context.go(
  '/sign-in',
  extra: (title: 'Success', subtitle: 'Check your email'),
);
```

**Pop (back navigation)**:

```dart
context.pop();

// Or with Go Router
GoRouter.of(context).pop();
```

**Push (non-replacing navigation)**:

```dart
context.push('/players/123');
```

### Extract Route Parameters

```dart
GoRoute(
  path: '/players/:id',
  pageBuilder: (context, state) {
    final playerId = state.pathParameters['id']!;
    return _noTransitionPage(
      key: state.pageKey,
      child: PlayerDetailPage(id: playerId),
    );
  },
),
```

---

## Network Connectivity

The [NetworkInfo](lib/core/network/network_info.dart) utility checks internet connectivity.

### Purpose

Before making API calls, the repository checks network status:

```dart
@override
Future<Either<Failure, Agent>> signIn({...}) async {
  if (await networkInfo.isConnected) {
    // Make API call
  } else {
    // Return NetworkFailure
    return const Left(NetworkFailure());
  }
}
```

### Implementation

```dart
abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final InternetConnection internetConnection;

  NetworkInfoImpl(this.connectivity, this.internetConnection);

  @override
  Future<bool> get isConnected async {
    // 1. Check if device has any connectivity
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    // 2. Check if internet is actually accessible
    return await internetConnection.hasInternetAccess;
  }
}

@riverpod
NetworkInfo networkInfo(Ref ref) {
  final connectivity = ref.watch(connectivityProvider);
  final internetConnection = ref.watch(internetConnectionProvider);
  return NetworkInfoImpl(connectivity, internetConnection);
}
```

### Two-Step Check

1. **Connectivity Check** (`connectivity_plus`): Does the device have WiFi/Mobile connection?
2. **Internet Check** (`internet_connection_checker_plus`): Can the device actually reach the internet?

This prevents false positives when connected to a WiFi network without internet access.

### Usage

```dart
// In repository
final isOnline = await networkInfo.isConnected;
if (isOnline) {
  // Fetch from API
} else {
  // Use cache or return NetworkFailure
}
```

---

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── app_startup.dart                   # Initialization logic
│
├── core/                              # Shared utilities & infrastructure
│   ├── database/
│   │   ├── app_database.dart          # Drift database definition
│   │   └── drift_riverpod_storage.g.dart
│   ├── error/
│   │   ├── failure.dart               # Failure union types
│   │   ├── exceptions.dart            # Exception definitions
│   │   └── failure.freezed.dart
│   ├── network/
│   │   ├── auth_interceptor.dart      # Token injection & refresh
│   │   ├── dio_client.dart            # HTTP client setup
│   │   ├── network_info.dart          # Connectivity check
│   │   └── token_refresher.dart       # Token refresh logic
│   ├── router/
│   │   └── router_provider.dart       # Go Router setup
│   ├── services/
│   │   ├── auth_status_notifier.dart  # Global auth state
│   │   └── app_settings_service.dart  # App settings (first open, etc.)
│   ├── storage/
│   │   ├── token_storage.dart         # Secure token persistence
│   │   ├── session_provider.dart      # RAM session (Riverpod)
│   │   └── shared_preferences.dart    # App preferences
│   ├── theme/                          # Material Design theme
│   ├── types/                          # Shared type aliases
│   ├── usecase/
│   │   └── usecase.dart               # Base UseCase class
│   ├── util/                           # Utility functions
│   └── widgets/                        # Shared UI components
│
├── features/                           # Feature modules
│   ├── auth/                           # Authentication feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_data_source.dart
│   │   │   │   └── auth_local_data_source.dart
│   │   │   ├── models/
│   │   │   │   └── agent_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_implementation.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── agent.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── sign_in.dart
│   │   │       ├── sign_up.dart
│   │   │       ├── sign_out.dart
│   │   │       └── ...
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   ├── auth_controller.dart
│   │       │   └── sign_up_notifier.dart
│   │       ├── pages/
│   │       │   ├── sign_in_form.dart
│   │       │   ├── sign_up_form_one.dart
│   │       │   ├── sign_up_form_two.dart
│   │       │   └── ...
│   │       └── widgets/
│   │           └── ... (auth-related widgets)
│   │
│   └── players/                       # Players feature (similar structure)
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── assets/
│   ├── images/
│   └── icons/
│
test/                                   # Unit & widget tests
├── core/
├── features/
└── fixtures/                           # Test data
```

---

## Testing Strategy

AgentPro follows **Test-Driven Development (TDD)** principles:

### Test Structure

```dart
// tests/features/auth/domain/usecases/sign_in_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('SignIn UseCase', () {
    late MockAuthRepository mockRepository;
    late SignIn useCase;

    setUp(() {
      mockRepository = MockAuthRepository();
      useCase = SignIn(mockRepository);
    });

    test('should return Agent on successful sign-in', () async {
      // Arrange
      final email = 'test@example.com';
      final password = 'password123';
      final agent = Agent(...);
      when(() => mockRepository.signIn(
        email: email,
        password: password,
        rememberMe: false,
      )).thenAnswer((_) async => Right(agent));

      // Act
      final result = await useCase((
        email: email,
        password: password,
        rememberMe: false,
      ));

      // Assert
      expect(result, Right(agent));
      verify(
        () => mockRepository.signIn(
          email: email,
          password: password,
          rememberMe: false,
        ),
      ).called(1);
    });

    test('should return ServerFailure on API error', () async {
      // Arrange
      const failure = ServerFailure(message: 'Invalid credentials');
      when(() => mockRepository.signIn(...))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(...);

      // Assert
      expect(result, const Left(failure));
    });
  });
}
```

### Testing Best Practices

✅ **Use `fpdart`'s `Either` for assertions**:

```dart
expect(result, isA<Right>());
expect(result.getOrElse(() => null), isA<Agent>());
```

✅ **Test all failure types**:

```dart
test('should return NetworkFailure when offline', () async {
  when(() => networkInfo.isConnected).thenAnswer((_) async => false);
  final result = await repository.signIn(...);
  expect(result, const Left(NetworkFailure()));
});
```

✅ **Mock Riverpod providers in widget tests**:

```dart
testWidgets('SignIn form shows loading', (tester) async {
  await tester.pumpWidget(
    ProviderContainer(
      overrides: [
        signInMutationProvider.overrideWith((ref) => Mutation()),
      ],
      child: MaterialApp(...),
    ).contents,
  );
});
```

---

## Performance Considerations

### Optimization Tips

1. **Use `.keepAlive: true` for expensive providers**:

   ```dart
   @Riverpod(keepAlive: true)
   AppDatabase appDatabase(Ref ref) => AppDatabase();
   ```

2. **Lazy-load heavy resources**:

   ```dart
   // Use .future to delay computation
   await ref.watch(expensiveComputationProvider.future);
   ```

3. **Query optimization with Drift**:

   ```dart
   // Bad: Loads all rows
   final all = await database.select(database.keyValueStore).get();

   // Good: Filters at database level
   final specific = await (database.select(database.keyValueStore)
     ..where((t) => t.key.equals('specific_key')))
     .getSingleOrNull();
   ```

4. **Cache frequently-accessed data**:
   - Tokens are cached in RAM (SessionProvider)
   - User data is cached in Drift database
   - Settings are cached in SharedPreferences

---

## Common Issues & Solutions

### Issue: "Element reparent in the same renderObject" during navigation

**Solution**: Always pass `key: state.pageKey` to `MaterialPage`/`NoTransitionPage`:

```dart
pageBuilder: (context, state) => _noTransitionPage(
  key: state.pageKey,  // ✅ Add this
  child: MyPage(),
),
```

### Issue: Mutation throws unhandled exception

**Solution**: Catch `Failure` exceptions in `mutation.run()`:

```dart
await mutation.run(ref, (tsx) async {
  final useCase = tsx.get(useCaseProvider);
  final result = await useCase(params);
  return result.fold(
    (failure) => throw failure,  // Convert Failure to exception
    (success) => success,
  );
});
```

### Issue: Token not persisting after app restart

**Solution**: Ensure `TokenStorage` is saving to `flutter_secure_storage`:

```dart
Future<void> saveAccessToken(String token) async {
  await _secureStorage.write(key: 'access_token', value: token);
  // Also update RAM for instant access
  ref.read(sessionProvider.notifier).setToken(token);
}
```

### Issue: Drift database migration fails

**Solution**: Increment `schemaVersion` and provide migration logic:

```dart
@override
int get schemaVersion => 2; // Increment from 1

@override
MigrationStrategy get migration => MigrationStrategy(
  onUpgrade: (migrator, from, to) async {
    if (from == 1 && to == 2) {
      // Add migration logic here
      await migrator.addColumn(keyValueStore, keyValueStore.expireAt);
    }
  },
);
```

---

## Code Generation

This project uses code generation for type safety and boilerplate reduction:

```bash
# Watch mode (auto-regenerate on save)
dart run build_runner watch --delete-conflicting-outputs

# One-time build
dart run build_runner build --delete-conflicting-outputs

# Clean and rebuild
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

**Generated Files** (`.g.dart`):

- `*.freezed.dart` - Freezed data classes (`@freezed`)
- `*.g.dart` - Riverpod providers (`@riverpod`), JSON serialization (`@JsonSerializable`)
- `app_database.g.dart` - Drift database (`@DriftDatabase`)

---

## Resources & References

- **Clean Architecture**: [Uncle Bob's Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- **FPDART**: [Functional Programming in Dart](https://github.com/SandroMaglione/fpdart)
- **Riverpod**: [Riverpod Documentation](https://riverpod.dev)
- **Drift**: [Drift Documentation](https://drift.simonbinder.eu/)
- **Go Router**: [Go Router Documentation](https://pub.dev/packages/go_router)

---

## Contributing

When contributing to this project:

1. **Follow the architecture**: Place files in the correct layer (presentation, domain, data, core)
2. **Use functional error handling**: Return `Either<Failure, T>` from repositories
3. **Write tests first**: Follow TDD principles
4. **Use Riverpod for DI**: Don't instantiate classes directly
5. **Document complex logic**: Add comments explaining "why", not "what"

---

## License

This project is proprietary and confidential.

---

**Last Updated**: March 31, 2026  
**Maintainers**: AgentPro Development Team
