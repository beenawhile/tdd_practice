import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tddpractice/core/domain/entity/exception.dart';
import 'package:tddpractice/core/domain/entity/failure.dart';
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

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(number: tNumber, text: "test");
  const tNumberTriviaDto = NumberTriviaDto(number: tNumber, text: "test");

  void _setEnvironmentOnline(Function onlineCallback) {
    group(
      "device is online",
      () {
        setUp(() {
          when(() => network.isOnline).thenAnswer((_) async => true);
        });

        onlineCallback();
      },
    );
  }

  void _setEnvironmentOffline(Function offlineCallback) {
    group(
      "device is offline",
      () {
        setUp(() {
          when(() => network.isOnline).thenAnswer((_) async => false);
        });

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
      test(
        "should check if device is connected to internet",
        () async {
          when(() => network.isOnline).thenAnswer((_) async => true);
          when(() => remote.getConcreteNumberTrivia(any()))
              .thenAnswer((_) async => tNumberTriviaDto);
          when(() => local.cacheNumberTrivia(tNumberTriviaDto))
              .thenAnswer((_) async {});

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
              when(() => local.cacheNumberTrivia(tNumberTriviaDto))
                  .thenAnswer((_) async {});

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
              when(() => local.cacheNumberTrivia(tNumberTriviaDto))
                  .thenAnswer((_) async {});

              await repository.getConcreteNumberTrivia(tNumber);
              verify(() => remote.getConcreteNumberTrivia(tNumber));
              verify(() => local.cacheNumberTrivia(tNumberTriviaDto));
            },
          );

          test(
            "should return server failure when the call to remote data source is unsuccessful",
            () async {
              when(() => remote.getConcreteNumberTrivia(any()))
                  .thenThrow(ServerException());

              final results = await repository.getConcreteNumberTrivia(tNumber);
              verifyZeroInteractions(local);
              expect(results, equals(const Left(ServerFailure())));
            },
          );
        },
      );

      _setEnvironmentOffline(
        () {
          test(
            "should return last locally cached data when the cached data is present",
            () async {
              when(() => local.getLastNumberTrivia())
                  .thenAnswer((_) async => tNumberTriviaDto);

              final results = await repository.getConcreteNumberTrivia(tNumber);

              verifyNoMoreInteractions(remote);
              verify(() => local.getLastNumberTrivia());
              expect(results, equals(const Right(tNumberTrivia)));
            },
          );

          test(
            "should return CacheFailure when there is no cached data present",
            () async {
              when(() => local.getLastNumberTrivia())
                  .thenThrow(CacheException());
              final results = await repository.getConcreteNumberTrivia(tNumber);
              verifyNoMoreInteractions(remote);
              verify(() => local.getLastNumberTrivia());
              expect(results, equals(const Left(CacheFailure())));
            },
          );
        },
      );
    },
  );

  group(
    "getRandomNumberTrivia",
    () {
      test(
        "should check if the device is online",
        () async {
          when(() => remote.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaDto);
          when(() => local.cacheNumberTrivia(tNumberTriviaDto))
              .thenAnswer((invocation) async => Future.value());
          when(() => network.isOnline).thenAnswer((_) async => true);

          await repository.getRandomNumberTrivia();
          verify(() => network.isOnline).called(1);
        },
      );

      _setEnvironmentOnline(
        () {
          test(
            "should return remote data when call to remote data source is successful",
            () async {
              when(() => remote.getRandomNumberTrivia())
                  .thenAnswer((_) async => tNumberTriviaDto);
              when(() => local.cacheNumberTrivia(tNumberTriviaDto))
                  .thenAnswer((invocation) async => Future.value());

              final results = await repository.getRandomNumberTrivia();
              verify(() => remote.getRandomNumberTrivia());
              expect(results, equals(const Right(tNumberTrivia)));
            },
          );

          test(
            "should cahce the data locally when the call to remote data source is successful",
            () async {
              when(() => remote.getRandomNumberTrivia())
                  .thenAnswer((_) async => tNumberTriviaDto);
              when(() => local.cacheNumberTrivia(tNumberTriviaDto))
                  .thenAnswer((invocation) async => Future.value());

              await repository.getRandomNumberTrivia();

              verify(() => local.cacheNumberTrivia(tNumberTriviaDto));
            },
          );

          test(
            "should return server failure when the call to remote data source is unsuccessful",
            () async {
              when(() => remote.getRandomNumberTrivia())
                  .thenThrow(ServerException());

              final results = await repository.getRandomNumberTrivia();
              verifyZeroInteractions(local);
              expect(results, equals(const Left(ServerFailure())));
            },
          );
        },
      );

      _setEnvironmentOffline(
        () {
          test(
            "should return last locally cached data when the cached data is present",
            () async {
              when(() => local.getLastNumberTrivia())
                  .thenAnswer((_) async => tNumberTriviaDto);

              final results = await repository.getRandomNumberTrivia();

              verifyNoMoreInteractions(remote);
              verify(() => local.getLastNumberTrivia());
              expect(results, equals(const Right(tNumberTrivia)));
            },
          );

          test(
            "should return CacheFailure when there is no cached data present",
            () async {
              when(() => local.getLastNumberTrivia())
                  .thenThrow(CacheException());
              final results = await repository.getRandomNumberTrivia();
              verifyNoMoreInteractions(remote);
              verify(() => local.getLastNumberTrivia());
              expect(results, equals(const Left(CacheFailure())));
            },
          );
        },
      );
    },
  );
}
