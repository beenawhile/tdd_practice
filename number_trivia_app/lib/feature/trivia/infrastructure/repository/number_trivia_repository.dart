import 'package:tddpractice/core/domain/entity/exception.dart';
import 'package:tddpractice/core/infrastructure/i_network_info.dart';
import 'package:tddpractice/feature/trivia/domain/entity/number_trivia.dart';
import 'package:tddpractice/core/domain/entity/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tddpractice/feature/trivia/domain/repository/i_number_trivia_repository.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/local/i_number_trivia_local_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/datasource/remote/i_number_trivia_remote_datasource.dart';
import 'package:tddpractice/feature/trivia/infrastructure/dto/number_trivia_dto.dart';

class NumberTriviaRepository implements INumberTriviaRepository {
  NumberTriviaRepository({
    required INetworkInfo network,
    required INumberTriviaLocalDataSource local,
    required INumberTriviaRemoteDatasource remote,
  })  : _network = network,
        _local = local,
        _remote = remote;

  final INetworkInfo _network;
  final INumberTriviaLocalDataSource _local;
  final INumberTriviaRemoteDatasource _remote;

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return _getTrivia(() => _remote.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return _getTrivia(() => _remote.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      Future<NumberTriviaDto> Function() getConcreteOrRandom) async {
    if (await _network.isOnline) {
      try {
        final results = await getConcreteOrRandom();
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
}
