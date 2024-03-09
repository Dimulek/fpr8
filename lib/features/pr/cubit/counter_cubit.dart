import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:fpr8/features/pr/domain/entity/pr_entity.dart';
import 'package:fpr8/features/pr/domain/repository/pr_repository.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final PrRepository _repo;
  List<PrEntity> get getPrList => state.prList;

  CounterCubit(this._repo) : super(const CounterLoading(prList: []));
  void init() async {
    final result = await _repo.writePr(false);

    result.fold((l) => emit(const CounterException(prList: [])),
        (list) => emit(CounterSuccess(prList: list)));
  }

  Future<void> reload() async {
    emit(const CounterInitial(prList: []));
  }

  Future<void> addPr(String title, String description, String fullDesc) async {
    int index = -1, id = -1;
    for (int i = 0; i < state.prList.length; ++i) {
      if (int.parse(state.prList[i].id) > id) {
        id = int.parse(state.prList[i].id);
        index = i;
      }
    }
    final entity = PrEntity(
      id: (state.prList.isEmpty
          ? "0"
          : "${(index == -1 ? 0 : int.parse(state.prList[index].id) + 1)}"),
      title: title,
      description: description,
      full_description: fullDesc,
    );
    final result = await _repo.readPr(entity);

    result.fold((l) => null, (r) {
      state.prList.add(entity);
    });
    reload();
  }

  Future<void> updatePr(
      int index, String title, String description, String fullDesc) async {
    final entity = PrEntity(
      id: state.prList[index].id,
      title: title,
      description: description,
      full_description: fullDesc,
    );
    final result = await _repo.updatePr(index, entity);
    result.fold((l) => null, (r) {
      state.prList[index] = state.prList[index].copyWith(entity);
    });
    reload();
  }

  Future<void> deletePr(int index, {bool is_mass = false}) async {
    final entity = state.prList[index];
    final result = await _repo.deletePr(entity);
    result.fold((l) => null, (r) {
      state.prList.removeAt(index);
    });
    if (!is_mass) reload();
  }

  Future<void> deleteMassPr(Set<int> indexes) async {
    for (int i = indexes.length - 1; i >= 0; --i) {
      deletePr(indexes.elementAt(i), is_mass: i != 0);
    }
  }
}
