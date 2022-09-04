abstract class Failure {}

class ServerFailure implements Failure {
  const ServerFailure();
}

class CacheFailure implements Failure {
  const CacheFailure();
}

class InvalidInputFailure implements Failure {
  const InvalidInputFailure();
}
