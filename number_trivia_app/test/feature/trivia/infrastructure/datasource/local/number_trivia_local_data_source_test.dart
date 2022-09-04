import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddpractice/core/domain/entity/exception.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/local/number_trivia_local_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/dto/number_trivia_dto.dart';

import '../../../../../fixture/fixture.dart';
import 'mock_trivia_box.dart';

void main() {
  late MockTriviaBox storage;
  late NumberTriviaLocalDatasource datasource;

  setUp(
    () {
      storage = MockTriviaBox();
      datasource = NumberTriviaLocalDatasource(storage: storage);
    },
  );

  group(
    "getLatestNumberTrivia",
    () {
      final tNumberTriviaDto =
          NumberTriviaDto.fromJson(fixture("trivia_cached.json"));

      test(
        "should return NumberTrivia from Box<String> when there is one cached",
        () async {
          when(() => storage.get(any()))
              .thenAnswer((_) => fixture("trivia_cached.json"));
          final results = await datasource.getLastNumberTrivia();

          verify(() => storage.get("CACHE_TRIVIA"));

          expect(results, tNumberTriviaDto);
        },
      );

      test(
        "should throw CacheException when there is none cached",
        () async {
          when(() => storage.get(any())).thenAnswer((_) => null);

          final results = datasource.getLastNumberTrivia;

          expect(() => results(), throwsA(isA<CacheException>()));
        },
      );
    },
  );

  group(
    "cacheNumberTrivia",
    () {
      const tNumberTriviaDto = NumberTriviaDto(number: 1, text: "test");

      final tNumberTriviaString = tNumberTriviaDto.toJson();

      test(
        "should call Box.put() to cahce the data",
        () async {
          when(() => storage.put(any(), any()))
              .thenAnswer((invocation) => Future.value());
          datasource.cacheNumberTrivia(tNumberTriviaDto);
          verify(() => storage.put("CACHE_TRIVIA", tNumberTriviaString));
        },
      );
    },
  );
}
