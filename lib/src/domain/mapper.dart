mixin IMapper<T, P> {
  T from(P entity);
}

mixin IListMapper<T, P> implements IMapper<T, P> {
  List<T> fromList(List<P> entityList) {
    return entityList.map((e) => from(e)).toList();
  }
}
