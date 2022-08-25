import 'package:tddpractice/feature/trivia/infrastructure/dto/number_trivia_dto.dart';

abstract class INumberTriviaRemoteDatasource {
  Future<NumberTriviaDto> getConcreteNumberTrivia(int number);
  Future<NumberTriviaDto> getRandomNumberTrivia();
}
