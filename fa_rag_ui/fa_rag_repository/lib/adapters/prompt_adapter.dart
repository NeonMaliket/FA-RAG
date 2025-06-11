import 'package:fa_rag_core/core/domain/prompts/prompt.dart';
import 'package:hive/hive.dart';

class PromptAdapter extends TypeAdapter<Prompt> {
  @override
  Prompt read(BinaryReader reader) {
    final json = reader.readString();
    return Prompt.fromJson(json);
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, Prompt obj) {
    final json = obj.toJson();
    writer.writeString(json);
  }
}
