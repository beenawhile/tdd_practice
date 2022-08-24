import 'dart:convert';

import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';

class NumberTriviaDto {
  const NumberTriviaDto({
    required this.number,
    required this.text,
  });

  final int number;
  final String text;

  factory NumberTriviaDto.fromDomain(NumberTrivia domain) {
    return NumberTriviaDto(number: domain.number, text: domain.text);
  }

  NumberTrivia toDomain() => NumberTrivia(number: number, text: text);

  NumberTriviaDto copyWith({
    int? number,
    String? text,
  }) {
    return NumberTriviaDto(
      number: number ?? this.number,
      text: text ?? this.text,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NumberTriviaDto &&
        other.number == number &&
        other.text == text;
  }

  @override
  int get hashCode => number.hashCode ^ text.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'text': text,
    };
  }

  factory NumberTriviaDto.fromMap(Map<String, dynamic> map) {
    return NumberTriviaDto(
      number: map['number']?.toInt() ?? 0,
      text: map['text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NumberTriviaDto.fromJson(String source) =>
      NumberTriviaDto.fromMap(json.decode(source));
}
