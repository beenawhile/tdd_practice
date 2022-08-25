import 'package:patternify/src/features/playlist/memento/memento.dart';
import 'package:patternify/src/features/playlist/memento/originator.dart';
import 'package:patternify/src/features/playlist/models/playlist.dart';

abstract class IPlaylistCommand {
  Playlist execute();
  Playlist undo();
}

abstract class PlaylistCommand implements IPlaylistCommand {
  PlaylistCommand(this.originator) : backup = originator.createMemento();

  final Originator originator;
  final Memento backup;

  @override
  Playlist undo() {
    originator.restore(backup);

    return originator.state;
  }
}
