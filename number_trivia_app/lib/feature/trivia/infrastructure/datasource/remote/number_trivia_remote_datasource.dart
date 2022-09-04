import 'package:dio/dio.dart';
import 'package:tddpractice/core/domain/entity/exception.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/remote/i_number_trivia_remote_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/dto/number_trivia_dto.dart';

const remoteNumberTriviaBaseUrl = 'http://numbersapi.com';

class NumberTriviaRemoteDatasource implements INumberTriviaRemoteDatasource {
  final Dio _httpClient;

  const NumberTriviaRemoteDatasource({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<NumberTriviaDto> getConcreteNumberTrivia(int number) async {
    try {
      final results =
          await _httpClient.get("$remoteNumberTriviaBaseUrl/$number?json");
      return NumberTriviaDto.fromMap(results.data);
    } on DioError {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaDto> getRandomNumberTrivia() async {
    try {
      final results =
          await _httpClient.get("$remoteNumberTriviaBaseUrl/random?json");
      return NumberTriviaDto.fromMap(results.data);
    } on DioError {
      throw ServerException();
    }
  }
}
