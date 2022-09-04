import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddpractice/core/domain/entity/failure.dart';
import 'package:tddpractice/feature/trivia/application/event/number_trivia_event.dart';
import 'package:tddpractice/feature/trivia/application/state/number_trivia_state.dart';
import 'package:tddpractice/feature/trivia/dependency_injection.dart';
import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';

import 'mock_usecase.dart';

void main() {
  late MockGetRandomNumberTrivia randomUsecase;
  late MockGetConcreteNumberTrivia concreteUsecase;
  late MockInputConverter mockInputConverter;
  late Box<String> hiveStorage;

  const tNumberString = "1";
  const tNumberParse = 1;
  const tNumberTrivia = NumberTrivia(number: 1, text: "test");

  setUp(
    () async {
      randomUsecase = MockGetRandomNumberTrivia();
      concreteUsecase = MockGetConcreteNumberTrivia();
      mockInputConverter = MockInputConverter();

      final path = Directory.current.path;
      Hive.init('$path/test/fixture');

      hiveStorage = (await Hive.openBox<String>("trivia"));
    },
  );

  ProviderContainer setProviderContainerForTest() {
    final container = ProviderContainer(
      overrides: [
        concreteUsecaseProvider.overrideWithValue(concreteUsecase),
        randomUsecaseProvider.overrideWithValue(randomUsecase),
        triviaStorageProvider.overrideWithValue(hiveStorage),
        inputConverterProvider.overrideWithValue(mockInputConverter),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test(
    "initial state should be initial()",
    () async {
      final container = setProviderContainerForTest();
      expect(container.read(numberTriviaStateNotifierProvider),
          NumberTriviaState.initial());
    },
  );

  group(
    "getConcreteNumberTrivia",
    () {
      void setUpMockInputConversionSuccess() {
        when(() => mockInputConverter.stringToUnsignedNumber(any()))
            .thenAnswer((_) => const Right(tNumberParse));
      }

      test(
        "should call inputConverter to validate and convert the string to unsigned integer",
        () async {
          final container = setProviderContainerForTest();

          setUpMockInputConversionSuccess();

          when(() => concreteUsecase(any()))
              .thenAnswer((_) async => const Right(tNumberTrivia));

          container
              .read(numberTriviaStateNotifierProvider.notifier)
              .mapEventToState(NumberTriviaEvent.concrete(tNumberString));

          await untilCalled(
              () => mockInputConverter.stringToUnsignedNumber(any()));
          verify(
              () => mockInputConverter.stringToUnsignedNumber(tNumberString));
        },
      );

      test(
        "should emit [Failure] when input is invalid",
        () async {
          final container = setProviderContainerForTest();

          when(() => mockInputConverter.stringToUnsignedNumber(any()))
              .thenAnswer((_) => const Left(InvalidInputFailure()));

          await container
              .read(numberTriviaStateNotifierProvider.notifier)
              .mapEventToState(NumberTriviaEvent.concrete(tNumberString));

          expect(container.read(numberTriviaStateNotifierProvider),
              isA<NumberTriviaFailureState>());
        },
      );
    },
  );
}
