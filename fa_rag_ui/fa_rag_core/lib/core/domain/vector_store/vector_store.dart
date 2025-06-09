import 'package:equatable/equatable.dart';
import 'package:fa_rag_core/core/domain/vector_store/vector.dart';

abstract class VectorStore extends Equatable {
  final String name;
  final String description;
  final String? url;
  final String? apiKey;

  const VectorStore({
    required this.name,
    required this.description,
    this.url,
    this.apiKey,
  });

  Future<bool> testConnection();
  Future<void> disconnect();
  Future<void> connect();

  Future<List<Vector>> search(String document, Vector vector);
  Future<void> clear(String document);
  Future<void> saveVector(String document, Vector vector);

  @override
  String toString() {
    return 'VectorStore(name: $name, description: $description, url: $url, apiKey: $apiKey)';
  }

  @override
  List<Object?> get props => [name, description, url, apiKey];
}
