import 'package:flutter/material.dart';
import 'package:fpr8/features/pr/domain/entity/pr_entity.dart';
import 'package:fpr8/features/pr/domain/repository/pr_repository.dart';
import 'package:uuid/uuid.dart';

enum PrState {
  initial,
  loading,
  success,
  error,
}

class PrController with ChangeNotifier {
  final PrRepository _repo;
  List<PrEntity> _prList = [];
  List<PrEntity> get getPrList => _prList;

  int get getCount => getPrList.length;

  PrState state = PrState.initial;

  PrController(this._repo);

  void init() async {
    state = PrState.loading;

    final result = await _repo.writePr(false);

    result.fold(
      (l) => state = PrState.error,
      (list) => _prList = list,
    );

    state = PrState.success;
    notifyListeners();
  }

  Future<void> onTravel(int index) async {
    final entity = _prList[index];
    final result = await _repo.updatePr(entity);
    result.fold((l) => null, (r) {

    });
    notifyListeners();
  }

  Future<void> addPr(String title, String description, String full_description) async {
    final entity = PrEntity(
      id: const Uuid().v1(),
      title: title,
      description: description,
      full_description: full_description,
    );
    final result = await _repo.readPr(entity);

    result.fold((l) => null, (r) {
      _prList.add(entity);
    });
    notifyListeners();
  }

  Future<void> deletePr(int index) async {
    final entity = _prList[index];
    final result = await _repo.deletePr(entity);
    result.fold((l) => null, (r) {
      _prList.removeAt(index);
    });
    notifyListeners();
  }
}