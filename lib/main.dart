import 'package:agent_pro/app_startup.dart';
import 'core/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/util.dart';
import 'core/theme/theme.dart';

void main() async {
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  runApp(const ProviderScope(child: AgentProApp()));
}

class AgentProApp extends ConsumerWidget {
  const AgentProApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startup = ref.watch(appStartupProvider);
    return startup.when(
      loading: () => const SizedBox.shrink(), // Splash screen is still visible
      data: (_) {
        final router = ref.watch(routerProvider);
        final brightness = View.of(context).platformDispatcher.platformBrightness;
        TextTheme textTheme = createTextTheme(context, "Noto Sans Old Hungarian", "Maven Pro");
        MaterialTheme theme = MaterialTheme(textTheme);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'AgentPro',
          theme: brightness == Brightness.light ? theme.light() : theme.dark(),
          routerConfig: router,
          builder: (context, child) {
            return _StartupAssetWarmup(child: child!);
          },
        );
      },
      error: (e, st) {
        // Handle initialization errors here if needed
        FlutterNativeSplash.remove(); // Ensure splash screen is removed on error
        return MaterialApp(
          home: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Retry initialization by rebuilding the widget
                ref.invalidate(appStartupProvider);
              },
              child: const Icon(Icons.refresh),
            ),
            body: Center(
              child: Text(
                'Error during app initialization:\n$e',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StartupAssetWarmup extends StatefulWidget {
  const _StartupAssetWarmup({required this.child});

  final Widget child;

  @override
  State<_StartupAssetWarmup> createState() => _StartupAssetWarmupState();
}

class _StartupAssetWarmupState extends State<_StartupAssetWarmup> {
  bool _hasStarted = false;
  bool _hasRemovedSplash = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasStarted) return;
    _hasStarted = true;

    precacheImage(const AssetImage('assets/images/bg.jpg'), context)
        .catchError((_) {
          // Never block app startup if an optional warmup fails.
        })
        .whenComplete(_removeSplashOnce);
  }

  void _removeSplashOnce() {
    if (_hasRemovedSplash) return;
    _hasRemovedSplash = true;
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
