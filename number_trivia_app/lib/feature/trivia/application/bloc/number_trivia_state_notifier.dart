import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tddpractice/core/application/input_converter.dart';
import 'package:tddpractice/core/domain/entity/failure.dart';
import 'package:tddpractice/feature/trivia/application/event/number_trivia_event.dart';
import 'package:tddpractice/feature/trivia/application/state/number_trivia_state.dart';
import 'package:tddpractice/feature/trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:tddpractice/feature/trivia/domain/usecase/get_random_number_trivia.dart';

class NumberTriviaStateNotifier extends StateNotifier<NumberTriviaState> {
  NumberTriviaStateNotifier({
    required this.concreteUsecase,
    required this.randomUsecase,
    required this.inputConverter,
  }) : super(NumberTriviaState.initial());

  final GetConcreteNumberTrivia concreteUsecase;
  final GetRandomNumberTrivia randomUsecase;
  final InputConverter inputConverter;

  Future<void> mapEventToState(NumberTriviaEvent event) async {
    switch (event.runtimeType) {
      case GetTriviaForConcreteNumber:
        final failureOrNumber = inputConverter.stringToUnsignedNumber(
            (event as GetTriviaForConcreteNumber).rawNumberString);
        failureOrNumber.fold(
          (l) => state = NumberTriviaState.failure(mapFailureToMessage(l)),
          (r) async {
            final failureOrTrivia = await concreteUsecase(r);

            state = failureOrTrivia.fold(
              (l) => NumberTriviaState.failure(mapFailureToMessage(l)),
              (r) => NumberTriviaState.loaded(r),
            );
          },
        );
        break;
      case GetTriviaForRandomNumber:
        break;
    }
  }
}

String mapFailureToMessage(Failure failure) {
  if (failure is InvalidInputFailure) {
    return "Invalid Input";
  }

  return "";
}
