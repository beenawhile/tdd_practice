import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patternify/l10n/l10n.dart';
import 'package:patternify/src/core/presentation/router/app_router.dart';
import 'package:patternify/src/core/presentation/widgets/dependency_injection.dart';
import 'package:patternify/src/features/music_library/dependency_injection.dart';
import 'package:patternify/src/features/platform/platform.dart';

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  late PlatformWidgetsFactory widgetsFactory;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(musicLibraryContextStateNotifierProvider.notifier).nextState();
    });
  }

  PlatformWidgetsFactory _createPlatformWidgetsFactory() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const MaterialWidgetsFactory();
      case TargetPlatform.iOS:
        return const CupertinoWidgetsFactory();
      default:
        return const MaterialWidgetsFactory();
    }
  }

  @override
  Widget build(BuildContext context) {
    widgetsFactory = _createPlatformWidgetsFactory();
    widgetsFactoryProvider = Provider((ref) => widgetsFactory);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => context.l10n.appTitle,
      onGenerateRoute: (settings) =>
          AppRouter.generateRoute(settings, ref.watch(widgetsFactoryProvider)),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
