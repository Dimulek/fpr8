import 'package:get_it/get_it.dart';
import 'package:fpr8/features/todo/data/data_source.dart/todo_local_hive.dart';
import 'package:fpr8/features/todo/data/repository/todo_repository_impl.dart';
import 'package:fpr8/features/todo/domain/repository/todo_repositoty.dart';
import 'package:fpr8/features/todo/presentation/controller/todo_controller.dart';

final service = GetIt.instance;

Future<void> init() async {
  // StateManagment
  service.registerLazySingleton(() => TodoController(service()));
  // Use Case

  // Repository -> repository repository_impl, data_source -> local, remote
  service.registerLazySingleton<TodoLocalHive>(() => TodoLocalHiveimpl());
  service.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      local: service(),
    ),
  );
  // External -> Hive, SharedPrefrences ..

  await service<TodoLocalHive>().initDb();
}
