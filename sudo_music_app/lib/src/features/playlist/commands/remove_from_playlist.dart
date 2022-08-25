import 'package:patternify/src/features/music_library/models/song.dart';
import 'package:patternify/src/features/playlist/commands/playlist_command.dart';
import 'package:patternify/src/features/playlist/models/playlist.dart';

class RemoveFromPlaylistCommand extends PlaylistCommand {
  RemoveFromPlaylistCommand(
    super.originator, {
    required this.song,
  });

  final Song song;

  @override
  Playlist execute() {
    final playlist = backup.getState();

    return playlist.copyWith(songs: [...playlist.songs]..remove(song));
  }
}
