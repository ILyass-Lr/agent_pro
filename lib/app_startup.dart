import 'package:agent_pro/core/storage/shared_preferences.dart';
import 'package:agent_pro/features/auth/presentation/controllers/auth_init_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup.g.dart';

@riverpod
Future<void> appStartup(Ref ref) async {
  await ref.watch(sharedPreferencesProvider.future);
  await ref.watch(authInitProvider.future);
}
