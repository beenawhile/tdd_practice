import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patternify/src/features/music_library/music_library_repository.dart';
import 'package:patternify/src/features/music_library/music_library_service.dart';
import 'package:patternify/src/features/music_library/state/context/music_library_context.dart';
import 'package:patternify/src/features/music_library/state/state/music_library_state.dart';

final musicLibraryContextStateNotifierProvider =
    StateNotifierProvider<MusicLibraryContext, MusicLibraryState>(
  (ref) => MusicLibraryContext(service: ref.watch(musicLibraryServiceProvider)),
);

final musicLibraryServiceProvider = Provider(
  (ref) => MusicLibraryService(
      repository: ref.watch(musicLibraryRepositoryProvider)),
);

final musicLibraryRepositoryProvider = Provider(
  (ref) => const MusicLibraryRepository(),
);
