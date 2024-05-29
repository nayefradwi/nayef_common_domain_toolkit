const defaultLimit = 10;
const defaultOffset = 0;

abstract class PaginatedModel<T> {
  List<T> items;
  bool hasNextPage;

  PaginatedModel({
    required this.items,
    required this.hasNextPage,
  });

  void insert(T item) {
    items.insert(0, item);
  }
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

  factory LimitOffsetPage.withSingleItem(T item) {
    return LimitOffsetPage(
      items: [item],
      offset: defaultOffset,
      limit: defaultLimit,
      hasNextPage: false,
    );
  }

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

  factory CursorPage.withSingleItem(T item) {
    return CursorPage(
      items: [item],
      cursor: null,
      hasNextPage: false,
    );
  }

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

  factory DoubleCursorPage.withSingleItem(T item) {
    return DoubleCursorPage(
      items: [item],
      before: null,
      after: null,
      hasNextPage: false,
    );
  }

  void merge(DoubleCursorPage<T> other) {
    items.addAll(other.items);
    before = other.before;
    after = other.after;
    hasNextPage = other.hasNextPage;
  }
}
