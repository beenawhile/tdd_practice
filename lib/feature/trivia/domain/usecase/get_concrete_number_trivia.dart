import 'package:tddpractice/core/domain/entity/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tddpractice/core/domain/usecase/usecase.dart';
import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';
import 'package:tddpractice/feature/trivia/domain/repository/i_number_trivia_repository.dart';

class GetConcreteNumberTrivia implements Usecase<NumberTrivia, int> {
  const GetConcreteNumberTrivia({
    required INumberTriviaRepository repository,
  }) : _repository = repository;

  final INumberTriviaRepository _repository;

  @override
  Future<Either<Failure, NumberTrivia>> call(int params) async {
    return await _repository.getConcreteNumberTrivia(params);
  }
}
