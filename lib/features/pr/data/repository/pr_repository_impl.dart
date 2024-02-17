import 'package:dartz/dartz.dart';
import 'package:fpr8/core/error/exception.dart';
import 'package:fpr8/core/error/fauiler.dart';
import 'package:fpr8/features/pr/data/data_source.dart/pr_local_hive.dart';
import 'package:fpr8/features/pr/data/mapper/pr_mapper.dart';
import 'package:fpr8/features/pr/domain/entity/pr_entity.dart';
import 'package:fpr8/features/pr/domain/repository/pr_repository.dart';

class PrRepositoryImpl implements PrRepository {
  final PrLocalHive local;

  PrRepositoryImpl({required this.local});

  @override
  Future<Either<Fauiler, Unit>> readPr(PrEntity entity) async {
    try {
      await local.readPr(entity.toModel());
      return right(unit);
    } on CacheException catch (_) {
      return left(CacheFauiler());
    }
  }

  @override
  Future<Either<Fauiler, List<PrEntity>>> writePr([
    bool isFinished = false,
  ]) async {
    try {
      final data = await local.writePr();
      final result = data.map(
            (e) => e.toEntity(),
          )
          .toList();

      return right(result);
    } on CacheException catch (_) {
      return left(CacheFauiler());
    }
  }

  @override
  Future<Either<Fauiler, Unit>> updatePr(int index, PrEntity entity) async {
    try {
      await local.readPr(entity.toModel());
      return right(unit);
    } on CacheException catch (_) {
      return left(CacheFauiler());
    }
  }
  
  @override
  Future<Either<Fauiler, Unit>> deletePr(PrEntity entity) async {
    try {
      await local.deletePr(entity.toModel());
      return right(unit);
    } on CacheException catch (_) {
      return left(CacheFauiler());
    }
  }
}
