import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';
import 'package:tddpractice/feature/trivia/infrastructure/dto/number_trivia_dto.dart';
import 'package:tddpractice/feature/trivia/infrastructure/repository/number_trivia_repository.dart';

import 'mOCk_number_trivia_remote_datasource.dart';
import 'mock_network_info.dart';
import 'mock_number_trivia_local_datasource.dart';

void main() {
  late NumberTriviaRepository repository;
  late MockNetworkInfo network;
  late MockNumberTriviaLocalDatasource local;
  late MockNumberTriviaRemoteDatasource remote;

  void _setEnvironmentOnline(Function onlineCallback) {
    group(
      "device is online",
      () {
        setUp(
          () {
            when(() => network.isOnline).thenAnswer((_) async => true);
          },
        );
        onlineCallback();
      },
    );
  }

  void _setEnvironmentOffline(Function offlineCallback) {
    group(
      "device is offline",
      () {
        setUp(
          () {
            when(() => network.isOnline).thenAnswer((_) async => false);
          },
        );
        offlineCallback();
      },
    );
  }

  setUp(
    () {
      network = MockNetworkInfo();
      local = MockNumberTriviaLocalDatasource();
      remote = MockNumberTriviaRemoteDatasource();
      repository = NumberTriviaRepository(
        network: network,
        local: local,
        remote: remote,
      );
    },
  );

  group(
    "getConcreteNumberTrivia",
    () {
      const tNumber = 1;
      const tNumberTrivia = NumberTrivia(number: tNumber, text: "test");
      const tNumberTriviaDto = NumberTriviaDto(number: tNumber, text: "test");
      test(
        "should check if device is connected to internet",
        () async {
          when(() => network.isOnline).thenAnswer((_) async => true);
          when(() => remote.getConcreteNumberTrivia(any()))
              .thenAnswer((_) async => tNumberTriviaDto);
          repository.getConcreteNumberTrivia(tNumber);
          verify(() => network.isOnline);
        },
      );

      _setEnvironmentOnline(
        () {
          test(
            "should return remote data when the call to remote data source  is successful",
            () async {
              when(() => remote.getConcreteNumberTrivia(any()))
                  .thenAnswer((_) async => tNumberTriviaDto);

              final results = await repository.getConcreteNumberTrivia(tNumber);
              verify(() => remote.getConcreteNumberTrivia(tNumber));
              expect(results, equals(const Right(tNumberTrivia)));
            },
          );

          test(
            "should cache the data locally when the call to remote data source is successful",
            () async {
              when(() => remote.getConcreteNumberTrivia(any()))
                  .thenAnswer((_) async => tNumberTriviaDto);

              await repository.getConcreteNumberTrivia(tNumber);
              verify(() => remote.getConcreteNumberTrivia(tNumber));
              verify(() => local.cacheNumberTrivia(tNumberTriviaDto));
            },
          );
        },
      );
    },
  );
}
