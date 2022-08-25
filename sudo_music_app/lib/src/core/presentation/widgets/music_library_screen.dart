import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patternify/l10n/l10n.dart';
import 'package:patternify/src/core/presentation/widgets/dependency_injection.dart';
import 'package:patternify/src/core/presentation/widgets/summary_text.dart';
import 'package:patternify/src/features/music_library/composite/music_library_item.dart';
import 'package:patternify/src/features/music_library/dependency_injection.dart';
import 'package:patternify/src/features/music_library/state/state/music_library_state.dart';

class MusicLibraryScreen extends ConsumerWidget {
  static const route = '/music-library';

  const MusicLibraryScreen({
    this.title,
    this.musicLibraryItems,
    Key? key,
  }) : super(key: key);

  final String? title;
  final List<MusicLibraryItem>? musicLibraryItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetsFactory = ref.watch(widgetsFactoryProvider);

    if (title != null && musicLibraryItems != null) {
      return Scaffold(
        appBar: widgetsFactory.createAppBar(
          title: title!,
          showSettingsButton: false,
        ),
        body: _MusicLibraryView(musicLibraryItems: musicLibraryItems!),
      );
    }

    final MusicLibraryState status =
        ref.watch(musicLibraryContextStateNotifierProvider);

    switch (status.runtimeType) {
      case MusicLibraryInitialState:
        return const SizedBox();
      case MusicLibraryLoadingState:
        return widgetsFactory.createLoader();
      case MusicLibrarySuccessState:
        final items =
            ref.watch(musicLibraryContextStateNotifierProvider.notifier).items;
        return _MusicLibraryView(musicLibraryItems: items);
      case MusicLibraryErrorState:
        return const _ErrorView();
      default:
        return const SizedBox();
    }
  }
}

class _MusicLibraryView extends StatelessWidget {
  const _MusicLibraryView({
    required this.musicLibraryItems,
    Key? key,
  }) : super(key: key);

  final List<MusicLibraryItem> musicLibraryItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => musicLibraryItems[index].build(
              context,
            ),
            itemCount: musicLibraryItems.length,
          ),
        ),
        SummaryText(
          songsCount: musicLibraryItems.fold<int>(
            0,
            (prev, item) => prev + item.getItemsCount(),
          ),
          duration: musicLibraryItems.fold<int>(
            0,
            (prev, item) => prev + item.getDuration(),
          ),
        )
      ],
    );
  }
}

class _ErrorView extends ConsumerWidget {
  const _ErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(context.l10n.errorMessage),
        const SizedBox(height: 8.0),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => ref
              .read(musicLibraryContextStateNotifierProvider.notifier)
              .nextState(),
        ),
      ],
    );
  }
}
