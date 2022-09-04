import 'package:mocktail/mocktail.dart';
import 'package:tddpractice/core/application/input_converter.dart';
import 'package:tddpractice/feature/trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:tddpractice/feature/trivia/domain/usecase/get_random_number_trivia.dart';

class MockInputConverter extends Mock implements InputConverter {}

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}
