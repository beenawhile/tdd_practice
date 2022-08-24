import 'package:dartz/dartz.dart';
import 'package:tddpractice/core/domain/entity/failure.dart';
import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';

abstract class INumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
