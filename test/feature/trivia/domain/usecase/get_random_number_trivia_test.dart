import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddpractice/core/domain/entity/failure.dart';
import 'package:tddpractice/core/domain/usecase/no_params.dart';
import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';
import 'package:tddpractice/feature/trivia/domain/usecase/get_random_number_trivia.dart';

import 'mock_number_trivia_repository.dart';

void main() {
  late MockNumberTriviaRepository repository;
  late GetRandomNumberTrivia usecase;

  setUp(
    () {
      repository = MockNumberTriviaRepository();
      usecase = GetRandomNumberTrivia(repository: repository);
    },
  );

  group(
    "GetRandomNumberTrivia",
    () {
      const tNumberTrivia = NumberTrivia(number: 1, text: "test");

      test(
        "should return a NumberTrivia when all things are right",
        () async {
          when(() => repository.getRandomNumberTrivia()).thenAnswer(
            (_) async => const Right(tNumberTrivia),
          );

          final results = await usecase(const NoParams());
          expect(results, const Right(tNumberTrivia));
        },
      );

      test(
        "should return a ServerFailure when something goes wrong",
        () async {
          when(() => repository.getRandomNumberTrivia()).thenAnswer(
            (_) async => const Left(ServerFailure()),
          );

          final results = await usecase(const NoParams());
          expect(results, const Left(ServerFailure()));
        },
      );
    },
  );
}
