import 'package:flutter/material.dart';
import 'package:patternify/src/core/presentation/widgets/home_screen.dart';
import 'package:patternify/src/core/presentation/widgets/music_library_screen.dart';
import 'package:patternify/src/core/presentation/widgets/playlist_screen.dart';
import 'package:patternify/src/core/presentation/widgets/settings_screen.dart';
import 'package:patternify/src/features/music_library/composite/music_library_item.dart';
import 'package:patternify/src/features/platform/platform.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
    PlatformWidgetsFactory widgetsFactory,
  ) {
    switch (settings.name) {
      case HomeScreen.route:
        return widgetsFactory.createPageRouter(
          builder: (_) => const HomeScreen(),
        );
      case SettingsScreen.route:
        return widgetsFactory.createPageRouter(
          builder: (_) => const SettingsScreen(),
        );
      case PlaylistScreen.route:
        return widgetsFactory.createPageRouter(
          builder: (_) => const PlaylistScreen(),
        );
      case MusicLibraryScreen.route:
        final arguments = settings.arguments as Map<String, dynamic>;

        final title = arguments["title"] as String;
        final items = arguments["items"] as List<MusicLibraryItem>;

        return widgetsFactory.createPageRouter(
          builder: (_) => MusicLibraryScreen(
            title: title,
            musicLibraryItems: items,
          ),
        );
      default:
        return widgetsFactory.createPageRouter(
          builder: (context) => const HomeScreen(),
        );
    }
  }
}
