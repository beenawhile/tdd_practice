import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';
import 'package:tddpractice/feature/trivia/infrastructure/dto/number_trivia_dto.dart';

import '../../../../fixture/fixture.dart';

void main() {
  const tNumber = 1;
  const tNumberTriviaDto = NumberTriviaDto(number: tNumber, text: "test");

  test(
    "should get NumberTrivia entity",
    () async {
      expect(tNumberTriviaDto.toDomain(), isA<NumberTrivia>());
    },
  );

  group(
    "fromMap",
    () {
      test(
        "should return a valid dto when the JSON number is an integer",
        () async {
          final jsonMap = json.decode(fixture("trivia.json"));
          final results = NumberTriviaDto.fromMap(jsonMap);
          expect(results, tNumberTriviaDto);
        },
      );

      test(
        "should return a valid dto when the JSON number is regarded as a double",
        () async {
          final jsonMap = json.decode(fixture("trivia_double.json"));
          final results = NumberTriviaDto.fromMap(jsonMap);
          expect(results, tNumberTriviaDto);
        },
      );
    },
  );

  group(
    "toMap",
    () {
      test(
        "should return a JSON map containing proper data",
        () async {
          final results = tNumberTriviaDto.toMap();
          final expectedJsonMap = {"number": 1, "text": "test"};
          expect(results, expectedJsonMap);
        },
      );
    },
  );
}
