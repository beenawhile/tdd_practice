import 'package:tddpractice/feature/trivia/infrastructure/dto/number_trivia_dto.dart';

abstract class INumberTriviaLocalDataSource {
  Future<NumberTriviaDto> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaDto dto);
}
