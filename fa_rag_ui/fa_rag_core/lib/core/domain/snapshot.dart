class Snapshot {
  final String title;

  Snapshot(this.title);

  factory Snapshot.fromExport() {
    return Snapshot('Exported Snapshot');
  }
}
