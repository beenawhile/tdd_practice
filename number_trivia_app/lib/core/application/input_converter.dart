import 'package:dartz/dartz.dart';
import 'package:tddpractice/core/domain/entity/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedNumber(String rawInput) {
    final convertedValue = int.tryParse(rawInput);

    if (convertedValue == null) {
      return const Left(InvalidInputFailure());
    }
    return Right(convertedValue);
  }
}
