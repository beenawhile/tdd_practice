abstract class NumberTriviaEvent {
  const NumberTriviaEvent();

  factory NumberTriviaEvent.concrete(String rawNumberString) =>
      GetTriviaForConcreteNumber(rawNumberString);

  factory NumberTriviaEvent.random() => GetTriviaForRandomNumber();
}

class GetTriviaForConcreteNumber implements NumberTriviaEvent {
  const GetTriviaForConcreteNumber(this.rawNumberString);

  final String rawNumberString;
}

class GetTriviaForRandomNumber implements NumberTriviaEvent {}
