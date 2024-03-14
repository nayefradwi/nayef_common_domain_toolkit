abstract class PaginatedModel<T> {
  List<T> items;
  bool hasNextPage;

  PaginatedModel({
    required this.items,
    required this.hasNextPage,
  });
}

class LimitOffsetPage<T> extends PaginatedModel<T> {
  int offset;
  int limit;
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

class CursorPage<T> extends PaginatedModel<T> {
  String? cursor;
  CursorPage({
    required super.items,
    required this.cursor,
    required super.hasNextPage,
  });

  void merge(CursorPage<T> other) {
    items.addAll(other.items);
    cursor = other.cursor;
    hasNextPage = other.hasNextPage;
  }
}

class DoubleCursorPage<T> extends PaginatedModel<T> {
  String? before;
  String? after;
  DoubleCursorPage({
    required super.items,
    required this.before,
    required this.after,
    required super.hasNextPage,
  });

  void merge(DoubleCursorPage<T> other) {
    items.addAll(other.items);
    before = other.before;
    after = other.after;
    hasNextPage = other.hasNextPage;
  }
}
