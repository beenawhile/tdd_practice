import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patternify/src/features/playlist/cubit/playlist_state.dart';
import 'package:patternify/src/features/playlist/cubit/playlist_state_notifier.dart';

final playlistStateNotifierProvider =
    StateNotifierProvider<PlaylistStateNotifier, PlaylistState>(
  (ref) => PlaylistStateNotifier(),
);
