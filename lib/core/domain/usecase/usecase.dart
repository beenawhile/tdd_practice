import 'package:dartz/dartz.dart';
import 'package:tddpractice/core/domain/entity/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
