abstract class PaginatedModel<T> {
  List<T> items;
  bool hasNextPage;

  PaginatedModel({
    required this.items,
    required this.hasNextPage,
  });
}

class LimitOffsetPage<T> extends PaginatedModel<T> {
  int offset, limit;
  LimitOffsetPage({
    required super.items,
    required this.offset,
    required this.limit,
    required super.hasNextPage,
  });

  void merge(LimitOffsetPage<T> other) {
    items.addAll(other.items);
    offset = other.offset;
    limit = other.limit;
    hasNextPage = other.hasNextPage;
  }
}
