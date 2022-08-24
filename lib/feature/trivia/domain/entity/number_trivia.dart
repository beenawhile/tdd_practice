class NumberTrivia {
  const NumberTrivia({
    required this.number,
    required this.text,
  });

  final int number;
  final String text;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NumberTrivia &&
        other.number == number &&
        other.text == text;
  }

  @override
  int get hashCode => number.hashCode ^ text.hashCode;

  NumberTrivia copyWith({
    int? number,
    String? text,
  }) {
    return NumberTrivia(
      number: number ?? this.number,
      text: text ?? this.text,
    );
  }
}
