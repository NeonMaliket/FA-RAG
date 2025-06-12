abstract class CrudRepository<T> {
  Future<List<T>> getAll({Comparator<T>? compare});

  Future<T?> getById(String id);

  Future<void> create(T item);

  Future<void> update(String id, T item);

  Future<void> delete(String id);

  Future<bool> existsById(String id);
}
