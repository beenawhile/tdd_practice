import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patternify/l10n/l10n.dart';
import 'package:patternify/src/core/presentation/widgets/dependency_injection.dart';
import 'package:patternify/src/core/presentation/widgets/music_library_screen.dart';
import 'package:patternify/src/core/presentation/widgets/playlist_screen.dart';
import 'package:patternify/src/features/music_library/dependency_injection.dart';
import 'package:patternify/src/features/playlist/dependency_injection.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const route = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) => setState(() => _currentPageIndex = index);

  void _onBottomNavigationBarItemTap(int index) =>
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

  bool get _isMusicLibraryTap => _currentPageIndex == 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: ref.read(widgetsFactoryProvider).createAppBar(
            title: _isMusicLibraryTap ? l10n.appTitle : l10n.playlistTitle,
            showSettingsButton: _isMusicLibraryTap,
          ),
      bottomNavigationBar:
          ref.read(widgetsFactoryProvider).createBottomNavigationBar(
                currentIndex: _currentPageIndex,
                onTap: _onBottomNavigationBarItemTap,
              ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          MusicLibraryScreen(),
          PlaylistScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref
            .read(musicLibraryContextStateNotifierProvider.notifier)
            .nextState(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
