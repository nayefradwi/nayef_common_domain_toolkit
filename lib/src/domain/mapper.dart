import 'package:nayef_common_domain_toolkit/nayef_common_domain_toolkit.dart';

mixin IMapper<T, P> {
  T from(P other);
}

mixin IListMapper<T, P> implements IMapper<T, P> {
  List<T> fromList(List<P> otherList) {
    return otherList.map((e) => from(e)).toList();
  }
}

typedef _LimitOffsetPageMapper<T, P>
    = IMapper<LimitOffsetPage<T>, LimitOffsetPage<P>>;

class LimitOffsetPageMapper<T, P> implements _LimitOffsetPageMapper<T, P> {
  final IListMapper<T, P> listMapper;
  LimitOffsetPageMapper(this.listMapper);
  @override
  LimitOffsetPage<T> from(LimitOffsetPage<P> other) {
    final items = listMapper.fromList(other.items);
    return LimitOffsetPage<T>(
      items: items,
      hasNextPage: other.hasNextPage,
      offset: other.offset,
      limit: other.limit,
    );
  }
}
