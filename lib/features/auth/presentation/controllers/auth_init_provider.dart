import 'package:agent_pro/core/storage/session_provider.dart';
import 'package:agent_pro/core/storage/token_storage.dart';
import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:agent_pro/core/services/auth_status_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_init_provider.g.dart';

/// Responsible for initializing the authentication state of the app on startup.
/// It checks for an existing access token, validates it, and updates the [AuthStatusNotifier] accordingly.
@riverpod
Future<void> authInit(Ref ref) async {
  final storage = ref.watch(tokenStorageProvider);
  final accessToken = await storage.getAccessToken();

  if (accessToken != null) {
    ref.read(sessionProvider.notifier).setToken(accessToken);
    // Fetch the latest profile from server to check status
    final agent = await ref.read(authRepositoryProvider).getCurrentAgent();
    agent.fold(
      (failure) {
        // If fetching profile fails, clear session and token
        ref.read(sessionProvider.notifier).clearToken();
        storage.clearTokens();
        ref
            .read(authStatusProvider.notifier)
            .logout("Votre session a expiré. Veuillez vous reconnecter.");
      },
      (agent) {
        // If profile fetch is successful, we can consider the user authenticated
        ref.read(authStatusProvider.notifier).login(agent);
      },
    );
  } else {
    // If no access token, ensure session is clear
    ref.read(sessionProvider.notifier).clearToken();
    ref.read(authStatusProvider.notifier).logout();
  }
}
