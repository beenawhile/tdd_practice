import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';

abstract class NumberTriviaState {
  const NumberTriviaState();

  factory NumberTriviaState.initial() => const NumberTriviaInitialState();
  factory NumberTriviaState.loading() => const NumberTriviaLoadingState();
  factory NumberTriviaState.loaded(NumberTrivia trivia) =>
      NumberTriviaLoadedState(trivia);
  factory NumberTriviaState.failure(String message) =>
      NumberTriviaFailureState(message);
}

class NumberTriviaInitialState implements NumberTriviaState {
  const NumberTriviaInitialState();
}

class NumberTriviaLoadingState implements NumberTriviaState {
  const NumberTriviaLoadingState();
}

class NumberTriviaLoadedState implements NumberTriviaState {
  const NumberTriviaLoadedState(this.trivia);
  final NumberTrivia trivia;
}

class NumberTriviaFailureState implements NumberTriviaState {
  const NumberTriviaFailureState(this.message);
  final String message;
}
