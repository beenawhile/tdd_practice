import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddpractice/core/domain/entity/exception.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/remote/number_trivia_remote_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/dto/number_trivia_dto.dart';

import '../../../../../fixture/fixture.dart';
import 'mock_dio.dart';

void main() {
  late MockDio mockHttpClient;
  late NumberTriviaRemoteDatasource datasource;

  setUp(
    () {
      mockHttpClient = MockDio();
      datasource = NumberTriviaRemoteDatasource(httpClient: mockHttpClient);
    },
  );

  final tNumberTriviaReponseJsonString = fixture('trivia.json');

  final tNumberTriviaDto =
      NumberTriviaDto.fromJson(tNumberTriviaReponseJsonString);

  final tNumber = tNumberTriviaDto.number;

  const apiBaseUrl = "http://numbersapi.com";

  void _setUpSuccessfulNumberTriviaGetRequest({required String endpoint}) {
    when(() => mockHttpClient.get('$apiBaseUrl/$endpoint?json')).thenAnswer(
      (invocation) async {
        return Response(
          data: json.decode(tNumberTriviaReponseJsonString),
          requestOptions: RequestOptions(
            path: apiBaseUrl,
          ),
        );
      },
    );
  }

  group(
    "getConcreteNumberTrivia",
    () {
      test(
        "should perform a GET request on URL with number being the endpoint and with application/json header",
        () async {
          _setUpSuccessfulNumberTriviaGetRequest(endpoint: "$tNumber");

          final results = await datasource.getConcreteNumberTrivia(tNumber);

          verify(
            () => mockHttpClient.get("$apiBaseUrl/$tNumber?json"),
          );

          expect(results, tNumberTriviaDto);
        },
      );

      test(
        "should throw ServerException when something goes wrong",
        () async {
          when(() => mockHttpClient.get(any())).thenThrow(
              DioError(requestOptions: RequestOptions(path: "anything")));

          final call = datasource.getConcreteNumberTrivia;

          expect(() => call(tNumber), throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    "getRandomNumberTrivia",
    () {
      test(
        "should get random number when Dio Connection is successful",
        () async {
          _setUpSuccessfulNumberTriviaGetRequest(endpoint: "random");
          final results = await datasource.getRandomNumberTrivia();

          verify(() => mockHttpClient.get("$apiBaseUrl/random?json"));
          expect(results, tNumberTriviaDto);
        },
      );

      test(
        "should throw ServerException when something goes wrong",
        () async {
          when(() => mockHttpClient.get(any())).thenThrow(
              DioError(requestOptions: RequestOptions(path: "anything")));

          final call = datasource.getRandomNumberTrivia;

          expect(() => call(), throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
