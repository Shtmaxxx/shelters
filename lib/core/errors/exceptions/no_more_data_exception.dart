/// Throw this exception, when no data to load on scroll. (pagination)
class NoMoreDataException implements Exception {
  @override
  String toString() {
    return 'Nothing to load';
  }
}
