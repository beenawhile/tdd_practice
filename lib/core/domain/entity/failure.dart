abstract class Failure {}

class ServerFailure implements Failure {
  const ServerFailure();
}

class CacheFailure implements Failure {
  const CacheFailure();
}
