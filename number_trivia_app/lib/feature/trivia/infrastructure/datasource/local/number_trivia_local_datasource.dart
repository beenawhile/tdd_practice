import 'package:hive_flutter/hive_flutter.dart';
import 'package:tddpractice/core/domain/entity/exception.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/local/i_number_trivia_local_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/dto/number_trivia_dto.dart';

class NumberTriviaLocalDatasource implements INumberTriviaLocalDataSource {
  const NumberTriviaLocalDatasource({
    required Box<String> storage,
  }) : _storage = storage;

  final Box<String> _storage;

  @override
  Future<void> cacheNumberTrivia(NumberTriviaDto dto) async {
    _storage.put("CACHE_TRIVIA", dto.toJson());
  }

  @override
  Future<NumberTriviaDto> getLastNumberTrivia() async {
    final results = _storage.get("CACHE_TRIVIA");

    if (results == null) {
      throw CacheException();
    }

    return NumberTriviaDto.fromJson(results);
  }
}
