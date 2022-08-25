import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:patternify/src/features/music_library/composite/music_library_item.dart';
import 'package:patternify/src/features/music_library/models/song.dart';
import 'package:patternify/src/features/playlist/commands/add_to_playlist_command.dart';
import 'package:patternify/src/features/playlist/commands/remove_from_playlist.dart';
import 'package:patternify/src/features/playlist/dependency_injection.dart';
import 'package:patternify/src/features/playlist/memento/originator.dart';
import 'package:patternify/src/util/utils.dart';

class MusicLibrarySong extends StatelessWidget implements MusicLibraryItem {
  const MusicLibrarySong({
    super.key,
    required this.data,
  });

  final Song data;

  @override
  int getDuration() => data.duration;

  @override
  int getItemsCount() => 1;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final playlist = ref.watch(playlistStateNotifierProvider).playlist;
        final isInPlaylist = playlist.songs.contains(data);

        return Card(
          child: ListTile(
            title: Text(data.title),
            subtitle: Text("${data.artist} | ${getDuration().formatSeconds()}"),
            leading: Icon(
              Icons.music_note,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
            trailing: IconButton(
              onPressed: () {
                final originator = Originator(playlist);
                final command = isInPlaylist
                    ? RemoveFromPlaylistCommand(
                        originator,
                        song: data,
                      )
                    : AddToPlaylistCommand(originator, song: data);

                ref
                    .read(playlistStateNotifierProvider.notifier)
                    .executeCommand(command);
              },
              icon: Icon(
                isInPlaylist ? Icons.star : Icons.star_border,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
