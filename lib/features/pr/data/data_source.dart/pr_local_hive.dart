import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fpr8/core/error/exception.dart';
import 'package:fpr8/features/pr/data/model/pr_model.dart';

abstract interface class PrLocalHive {
  Future<bool> initDb();

  Future<Unit> readPr(PrModel model);
  Future<List<PrModel>> writePr();

  Future<Unit> updatePr(int index, PrModel model);
  Future<Unit> deletePr(PrModel model);
}

class PrLocalHiveimpl implements PrLocalHive {
  final _kObjectBox = 'object_box';

  @override
  Future<bool> initDb() async {
    try {
      if (!kIsWeb) {
        final appDocumentDir = await getApplicationDocumentsDirectory();
        Hive.init(appDocumentDir.path);
      }
      Hive.registerAdapter(PrModelAdapter());
      await Hive.openBox<PrModel>(_kObjectBox);
      return true;
    } catch (_) {
      throw InitDBException();
    }
  }

  @override
  Future<Unit> readPr(PrModel model) async {
    final objectBox = Hive.box<PrModel>(_kObjectBox);
    await objectBox.put(model.id, model);
    return Future.value(unit);
  }

  @override
  Future<List<PrModel>> writePr() async {
    try {
      final objectBox = Hive.box<PrModel>(_kObjectBox);
      return objectBox.values.toList();
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<Unit> updatePr(int index, PrModel model) async {
    try {
      final objectBox = Hive.box<PrModel>(_kObjectBox);
      await objectBox.putAt(index, model);
      return Future.value(unit);
    } catch (_) {
      throw CacheException();
    }
  }
  
  @override
  Future<Unit> deletePr(PrModel model) async {
    try {
      final objectBox = Hive.box<PrModel>(_kObjectBox);
      objectBox.delete(model.id);
      return Future.value(unit);
    } catch (_) {
      throw CacheException();
    }
  }
}
