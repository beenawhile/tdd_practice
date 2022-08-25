import 'package:patternify/src/features/playlist/models/playlist.dart';

class PlaylistState {
  const PlaylistState({
    this.playlist = const Playlist(),
    this.isCommandHistoryEmpty = true,
  });

  final Playlist playlist;
  final bool isCommandHistoryEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlaylistState &&
        other.playlist == playlist &&
        other.isCommandHistoryEmpty == isCommandHistoryEmpty;
  }

  @override
  int get hashCode => playlist.hashCode ^ isCommandHistoryEmpty.hashCode;

  @override
  String toString() =>
      'PlaylistState{ playlist: $playlist, isCommandHistoryEmpty: $isCommandHistoryEmpty }';
}
