import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patternify/l10n/l10n.dart';
import 'package:patternify/src/core/presentation/widgets/summary_text.dart';
import 'package:patternify/src/features/music_library/composite/music_library_song.dart';
import 'package:patternify/src/features/playlist/commands/reorder_playlist_command.dart';
import 'package:patternify/src/features/playlist/dependency_injection.dart';
import 'package:patternify/src/features/playlist/memento/originator.dart';

class PlaylistScreen extends ConsumerWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  static const route = "/playlist";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final playlist = ref.watch(playlistStateNotifierProvider).playlist;

    return playlist.songs.isEmpty
        ? Center(child: Text(l10n.playlistEmpty))
        : Column(
            children: [
              Expanded(
                child: ReorderableListView(
                  onReorder: ((oldIndex, newIndex) {
                    final command = ReorderPlaylistCommand(
                      Originator(playlist),
                      song: playlist.songs[oldIndex],
                      oldIndex: oldIndex,
                      newIndex: newIndex,
                    );

                    ref
                        .read(playlistStateNotifierProvider.notifier)
                        .executeCommand(command);
                  }),
                  children: [
                    for (final song in playlist.songs)
                      MusicLibrarySong(key: ValueKey(song), data: song),
                  ],
                ),
              ),
              SummaryText(
                songsCount: playlist.songs.length,
                duration: playlist.songs
                    .fold(0, (prev, song) => prev + song.duration),
              ),
            ],
          );
  }
}
