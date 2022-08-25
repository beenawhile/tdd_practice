import 'package:patternify/src/features/music_library/state/context/music_library_context.dart';

abstract class MusicLibraryState {
  Future nextState(MusicLibraryContext context);

  factory MusicLibraryState.initial() => MusicLibraryInitialState();
  factory MusicLibraryState.loading() => MusicLibraryLoadingState();
  factory MusicLibraryState.loaded() => MusicLibrarySuccessState();
  factory MusicLibraryState.error() => MusicLibraryErrorState();
}

class MusicLibraryInitialState implements MusicLibraryState {
  @override
  Future nextState(MusicLibraryContext context) async {
    context.setState(MusicLibraryLoadingState());
  }
}

class MusicLibraryLoadingState implements MusicLibraryState {
  @override
  Future nextState(MusicLibraryContext context) async {
    try {
      final data = await context.service.getMusicLibraryItems();
      context.items.clear();
      context.items.addAll(data);
      context.setState(MusicLibrarySuccessState());
    } catch (e) {
      context.setState(MusicLibraryErrorState());
    }
  }
}

class MusicLibrarySuccessState implements MusicLibraryState {
  @override
  Future nextState(MusicLibraryContext context) async {
    context.setState(MusicLibraryLoadingState());
  }
}

class MusicLibraryErrorState implements MusicLibraryState {
  @override
  Future nextState(MusicLibraryContext context) async {
    context.setState(MusicLibraryLoadingState());
  }
}
