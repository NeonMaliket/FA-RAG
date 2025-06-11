import 'package:fa_rag_repository/repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.enableRegisteringMultipleInstancesOfOneType();
  getIt.registerLazySingleton<CrudRepository>(() => PromptsRepository());
}
