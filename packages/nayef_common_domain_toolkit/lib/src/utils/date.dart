DateTime localDateFromString(String? date) {
  final local = DateTime.tryParse(date ?? '')?.toLocal();
  return local ?? DateTime.now();
}

DateTime? nullableLocalDateFromString(String? date) {
  return DateTime.tryParse(date ?? '')?.toLocal();
}
