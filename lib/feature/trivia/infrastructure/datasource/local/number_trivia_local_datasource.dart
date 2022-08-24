import 'package:tddpractice/feature/trivia/infrastructure/datasource/local/i_number_trivia_local_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/dto/number_trivia_dto.dart';

class NumberTriviaLocalDatasource implements INumberTriviaLocalDataSource {
  @override
  Future<void> cacheNumberTrivia(NumberTriviaDto dto) {
    // TODO: implement cacheNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaDto> getLastNumberTrivia() {
    // TODO: implement getLastNumberTrivia
    throw UnimplementedError();
  }
}
