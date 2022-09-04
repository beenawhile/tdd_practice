import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tddpractice/core/application/input_converter.dart';
import 'package:tddpractice/core/infrastructure/i_network_info.dart';
import 'package:tddpractice/core/infrastructure/network_info.dart';
import 'package:tddpractice/core/infrastructure/simple_network_connection_checker.dart';
import 'package:tddpractice/feature/trivia/application/bloc/number_trivia_state_notifier.dart';
import 'package:tddpractice/feature/trivia/application/state/number_trivia_state.dart';
import 'package:tddpractice/feature/trivia/domain/repository/i_number_trivia_repository.dart';
import 'package:tddpractice/feature/trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:tddpractice/feature/trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/local/i_number_trivia_local_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/local/number_trivia_local_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/remote/i_number_trivia_remote_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/remote/number_trivia_remote_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/repository/number_trivia_repository.dart';

final numberTriviaStateNotifierProvider =
    StateNotifierProvider<NumberTriviaStateNotifier, NumberTriviaState>(
  (ref) => NumberTriviaStateNotifier(
    concreteUsecase: ref.watch(concreteUsecaseProvider),
    randomUsecase: ref.watch(randomUsecaseProvider),
    inputConverter: ref.watch(inputConverterProvider),
  ),
);

final inputConverterProvider = Provider(
  (ref) => InputConverter(),
);

final concreteUsecaseProvider = Provider(
  (ref) => GetConcreteNumberTrivia(
      repository: ref.watch(numberTriviaRepositoryProvider)),
);

final randomUsecaseProvider = Provider(
  (ref) => GetRandomNumberTrivia(
      repository: ref.watch(numberTriviaRepositoryProvider)),
);

final numberTriviaRepositoryProvider = Provider<INumberTriviaRepository>(
  (ref) => NumberTriviaRepository(
    network: ref.watch(networkProvider),
    local: ref.watch(numberTriviaLocalDatasourceProvider),
    remote: ref.watch(numberTriviaRemoteDatasourceProvider),
  ),
);

final networkProvider = Provider<INetworkInfo>(
  (ref) => NetworkInfo(checker: ref.watch(networkCheckProvider)),
);

final networkCheckProvider = Provider(
  (ref) => SimpleNetworkConnectionChecker(),
);

final numberTriviaLocalDatasourceProvider =
    Provider<INumberTriviaLocalDataSource>(
  (ref) => NumberTriviaLocalDatasource(
    storage: ref.watch(triviaStorageProvider),
  ),
);

final triviaStorageProvider = Provider<Box<String>>(
  (ref) => throw UnimplementedError(),
);

final numberTriviaRemoteDatasourceProvider =
    Provider<INumberTriviaRemoteDatasource>(
  (ref) => NumberTriviaRemoteDatasource(httpClient: ref.watch(dioProvider)),
);

final dioProvider = Provider(
  (ref) => Dio(),
);
