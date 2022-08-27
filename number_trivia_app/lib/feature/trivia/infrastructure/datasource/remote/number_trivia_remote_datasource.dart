import 'package:tddpractice/feature/trivia/infrastructure/datasource/remote/i_number_trivia_remote_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/dto/number_trivia_dto.dart';

class NumberTriviaRemoteDatasource implements INumberTriviaRemoteDatasource {
  @override
  Future<NumberTriviaDto> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaDto> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
