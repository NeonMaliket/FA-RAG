import 'package:fa_rag_core/core/core.dart';
import 'package:fa_rag_repository/crud_repository.dart';
import 'package:hive/hive.dart';

class PromptsRepository extends CrudRepository<Prompt> {
  final box = Hive.box("prompts");

  @override
  Future<void> create(Prompt item) async {
    if (box.isOpen) {
      await box.put(item.title, item);
    } else {
      throw Exception("Box is not open");
    }
  }

  @override
  Future<void> delete(String title) async {
    if (box.isOpen) {
      await box.delete(title);
    } else {
      throw Exception("Box is not open");
    }
  }

  @override
  Future<List<Prompt>> getAll() async {
    if (box.isOpen) {
      return box.values.cast<Prompt>().toList();
    } else {
      throw Exception("Box is not open");
    }
  }

  @override
  Future<Prompt?> getById(String title) async {
    if (box.isOpen) {
      return await box.get(title) as Prompt?;
    } else {
      throw Exception("Box is not open");
    }
  }

  @override
  Future<void> update(String title, Prompt item) async {
    if (box.isOpen) {
      await box.put(title, item);
    } else {
      throw Exception("Box is not open");
    }
  }

  @override
  Future<bool> existsById(String id) async {
    if (box.isOpen) {
      return box.containsKey(id);
    } else {
      throw Exception("Box is not open");
    }
  }
}
