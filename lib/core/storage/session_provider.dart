import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_provider.g.dart';

@riverpod
class Session extends _$Session {
  @override
  String? build() => null;

  void setToken(String? token) => state = token;

  void clearToken() => state = null;
}
