import 'package:patternify/src/features/music_library/models/song.dart';
import 'package:patternify/src/features/playlist/commands/playlist_command.dart';
import 'package:patternify/src/features/playlist/models/playlist.dart';

class ReorderPlaylistCommand extends PlaylistCommand {
  ReorderPlaylistCommand(
    super.originator, {
    required this.song,
    required this.oldIndex,
    required this.newIndex,
  });

  final Song song;
  final int oldIndex;
  final int newIndex;

  @override
  Playlist execute() {
    final playlist = backup.getState();
    final insertAtIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;

    return playlist.copyWith(
      songs: [...playlist.songs]
        ..removeAt(oldIndex)
        ..insert(insertAtIndex, song),
    );
  }
}
