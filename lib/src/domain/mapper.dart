mixin IMapper<T, P> {
  T from(P other);
}

mixin IListMapper<T, P> implements IMapper<T, P> {
  List<T> fromList(List<P> otherList) {
    return otherList.map((e) => from(e)).toList();
  }
}
