import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:fpr8/features/pr/domain/entity/pr_entity.dart';
import 'package:fpr8/features/pr/domain/repository/pr_repository.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final PrRepository _repo;
  List<PrEntity> get getPrList => state.prList;

  CounterCubit(this._repo) : super(CounterLoading(prList: []));
  void init() async {
    final result = await _repo.writePr(false);

    result.fold((l) => emit(CounterException(prList: [])),
        (list) => emit(CounterSuccess(prList: list)));
  }

  Future<void> reload() async {
    emit(CounterInitial(prList: []));
  }

  Future<void> addPr(
      String title, String description, String full_description) async {
    final entity = PrEntity(
      id: (state.prList.length == 0
          ? "0"
          : "${(int.parse(state.prList.last.id) + 1)}"),
      title: title,
      description: description,
      full_description: full_description,
    );
    final result = await _repo.readPr(entity);

    result.fold((l) => null, (r) {
      state.prList.add(entity);
    });
    reload();
  }

  Future<void> updatePr(int index, String title, String description,
      String full_description) async {
    final entity = PrEntity(
      id: state.prList[index].id,
      title: title,
      description: description,
      full_description: full_description,
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
