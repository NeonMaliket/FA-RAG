class Vector {
  final List<double> values;

  Vector(this.values);

  @override
  String toString() {
    return 'Vector(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Vector) return false;
    return values == other.values;
  }

  @override
  int get hashCode => values.hashCode;
}
