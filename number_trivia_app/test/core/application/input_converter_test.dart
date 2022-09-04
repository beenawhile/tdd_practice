import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tddpractice/core/application/input_converter.dart';
import 'package:tddpractice/core/domain/entity/failure.dart';

void main() {
  late InputConverter converter;

  setUp(() {
    converter = InputConverter();
  });

  group(
    "InputConverte",
    () {
      const tRightNumber = 1;
      const tRightString = "$tRightNumber";
      const tWrongString = "wrong integer value";

      test(
        "should return integer when valid integer string is put",
        () async {
          final results = converter.stringToUnsignedNumber(tRightString);

          expect(results, const Right(tRightNumber));
        },
      );

      test(
        "should return failure when invalid string is put",
        () async {
          final results = converter.stringToUnsignedNumber(tWrongString);
          expect(results, const Left(InvalidInputFailure()));
        },
      );
    },
  );
}
