import 'package:dartz/dartz.dart';
import 'package:fpr8/core/error/fauiler.dart';
import 'package:fpr8/features/pr/domain/entity/pr_entity.dart';

abstract class PrRepository {
  Future<Either<Fauiler, List<PrEntity>>> writePr([
    bool isFinished = false,
  ]);
  Future<Either<Fauiler, Unit>> readPr(PrEntity entity);
  Future<Either<Fauiler, Unit>> updatePr(int index, PrEntity entity);
  Future<Either<Fauiler, Unit>> deletePr(PrEntity entity);

}
