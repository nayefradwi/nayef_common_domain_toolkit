extension FilterNullMap<T, P> on Map<T, P> {
  Map<T, P> filterOutNullValues() {
    final output = <T, P>{};
    for (final entry in entries) {
      if (entry.value == null) continue;
      output[entry.key] = entry.value;
    }
    return output;
  }
}

extension FilterNullList<T> on List<T> {
  List<T> filterOutNullValues() {
    return where((element) => element != null).toList();
  }
}
