import 'package:fa_rag_repository/adapters/adapters.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initHive() async {
  final dir = await getApplicationDocumentsDirectory();
  print("Hive directory: ${dir.path}");
  Hive.init(dir.path);
  registerAdapters();
  await openBoxies();
}

void registerAdapters() {
  Hive.registerAdapter(PromptAdapter());
}

Future<void> openBoxies() async {
  await Hive.openBox("prompts");
}
