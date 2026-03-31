import '../storage/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_settings_service.g.dart';

class AppSettingService {
  final SharedPreferences _prefs;
  static const _firstOpenKey = 'is_first_open';

  AppSettingService(this._prefs);

  // Default to true if the key doesn't exist
  bool get isFirstOpen => _prefs.getBool(_firstOpenKey) ?? true;

  Future<void> setOnBoardingComplete() async {
    await _prefs.setBool(_firstOpenKey, false);
  }
}

@riverpod
AppSettingService appSettingService(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value!;
  return AppSettingService(prefs);
}
