import 'either.dart';
import 'failure.dart';

abstract class GetDataUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
