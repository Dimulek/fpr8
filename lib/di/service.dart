import 'package:get_it/get_it.dart';
import 'package:fpr8/features/pr/data/data_source.dart/pr_local_hive.dart';
import 'package:fpr8/features/pr/data/repository/pr_repository_impl.dart';
import 'package:fpr8/features/pr/domain/repository/pr_repository.dart';
import 'package:fpr8/features/pr/presentation/controller/pr_controller.dart';

final service = GetIt.instance;

Future<void> init() async {
  // StateManagment
  service.registerLazySingleton(() => PrController(service()));
  // Use Case

  // Repository -> repository repository_impl, data_source -> local, remote
  service.registerLazySingleton<PrLocalHive>(() => PrLocalHiveimpl());
  service.registerLazySingleton<PrRepository>(
    () => PrRepositoryImpl(
      local: service(),
    ),
  );
  // External -> Hive, SharedPrefrences ..

  await service<PrLocalHive>().initDb();
}
