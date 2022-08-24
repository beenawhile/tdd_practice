import 'package:tddpractice/core/domain/entity/exception.dart';
import 'package:tddpractice/core/infrastructure/network_info.dart';
import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';
import 'package:tddpractice/core/domain/entity/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tddpractice/feature/trivia/domain/repository/i_number_trivia_repository.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/local/i_number_trivia_local_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/remote/i_number_trivia_remote_datasource.dart';

class NumberTriviaRepository implements INumberTriviaRepository {
  NumberTriviaRepository({
    required NetworkInfo network,
    required INumberTriviaLocalDataSource local,
    required INumberTriviaRemoteDatasource remote,
  })  : _network = network,
        _local = local,
        _remote = remote;

  final NetworkInfo _network;
  final INumberTriviaLocalDataSource _local;
  final INumberTriviaRemoteDatasource _remote;

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    if (await _network.isOnline) {
      try {
        final results = await _remote.getConcreteNumberTrivia(number);
        _local.cacheNumberTrivia(results);
        return Right(results.toDomain());
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final results = await _local.getLastNumberTrivia();
        return Right(results.toDomain());
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
