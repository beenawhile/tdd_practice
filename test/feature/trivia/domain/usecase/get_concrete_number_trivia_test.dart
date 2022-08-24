import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddpractice/core/domain/entity/failure.dart';
import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';
import 'package:tddpractice/feature/trivia/domain/usecase/get_concrete_number_trivia.dart';

import 'mock_number_trivia_repository.dart';

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository repository;

  setUp(
    () {
      repository = MockNumberTriviaRepository();
      usecase = GetConcreteNumberTrivia(repository: repository);
    },
  );

  group(
    "GetConcreteNumberTrivia",
    () {
      const tNumber = 1;
      const tNumberTrivia = NumberTrivia(number: tNumber, text: "test");

      test(
        "should return a NumberTrivia if all things are right",
        () async {
          when(() => repository.getConcreteNumberTrivia(any()))
              .thenAnswer((_) async => const Right(tNumberTrivia));
          final results = await usecase(tNumber);
          expect(results, const Right(tNumberTrivia));
        },
      );

      test(
        "should return a ServerFailure when something goes wrong",
        () async {
          when(() => repository.getConcreteNumberTrivia(any())).thenAnswer(
            (_) async => const Left(ServerFailure()),
          );

          final results = await usecase(tNumber);
          expect(results, const Left(ServerFailure()));
        },
      );
    },
  );
}
