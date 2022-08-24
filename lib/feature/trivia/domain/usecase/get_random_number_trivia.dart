import 'package:dartz/dartz.dart';

import 'package:tddpractice/core/domain/entity/failure.dart';
import 'package:tddpractice/core/domain/usecase/no_params.dart';
import 'package:tddpractice/core/domain/usecase/usecase.dart';
import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';
import 'package:tddpractice/feature/trivia/domain/repository/i_number_trivia_repository.dart';

class GetRandomNumberTrivia implements Usecase<NumberTrivia, NoParams> {
  const GetRandomNumberTrivia({
    required INumberTriviaRepository repository,
  }) : _repository = repository;

  final INumberTriviaRepository _repository;

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams _) async {
    return await _repository.getRandomNumberTrivia();
  }
}
