import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patternify/src/features/music_library/composite/music_library_item.dart';
import 'package:patternify/src/features/music_library/music_library_service.dart';
import 'package:patternify/src/features/music_library/state/state/music_library_state.dart';

class MusicLibraryContext extends StateNotifier<MusicLibraryState> {
  MusicLibraryContext({required this.service})
      : super(MusicLibraryState.initial());

  final MusicLibraryService service;

  final List<MusicLibraryItem> items = [];

  void setState(MusicLibraryState newState) {
    state = newState;
  }

  Future<void> nextState() async {
    await state.nextState(this);

    if (state is MusicLibraryLoadingState) {
      await state.nextState(this);
    }
  }
}
