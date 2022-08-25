import 'package:flutter/foundation.dart';

import 'package:patternify/src/features/music_library/models/song.dart';

class Playlist {
  const Playlist({
    this.songs = const [],
  });

  final List<Song> songs;

  Playlist.copy(Playlist playlist) : this(songs: playlist.songs);

  Playlist copyWith({
    List<Song>? songs,
  }) {
    return Playlist(
      songs: songs ?? this.songs,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Playlist && listEquals(other.songs, songs);
  }

  @override
  int get hashCode => songs.hashCode;

  @override
  String toString() => 'Playlist{ songs: $songs }';
}
