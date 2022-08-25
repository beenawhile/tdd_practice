import 'package:patternify/src/features/playlist/models/playlist.dart';

abstract class Memento {
  Playlist getState();
}

class PlaylistMemento implements Memento {
  final Playlist _state;

  PlaylistMemento(Playlist playlist) : _state = Playlist.copy(playlist);

  @override
  Playlist getState() => _state;
}
