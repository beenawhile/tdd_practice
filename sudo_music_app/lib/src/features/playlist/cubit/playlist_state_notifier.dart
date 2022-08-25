import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patternify/src/features/playlist/commands/playlist_command.dart';
import 'package:patternify/src/features/playlist/cubit/playlist_state.dart';

class PlaylistStateNotifier extends StateNotifier<PlaylistState> {
  PlaylistStateNotifier() : super(const PlaylistState());

  final ListQueue<IPlaylistCommand> _commandHistory = ListQueue();

  void executeCommand(IPlaylistCommand command) {
    _commandHistory.addLast(command);

    final playlist = command.execute();

    state = PlaylistState(playlist: playlist, isCommandHistoryEmpty: false);
  }

  void undoLastCommand() {
    if (_commandHistory.isNotEmpty) {
      final playlistCommand = _commandHistory.removeLast();
      final playlist = playlistCommand.undo();

      state = PlaylistState(
          playlist: playlist, isCommandHistoryEmpty: _commandHistory.isEmpty);
    }
  }
}
