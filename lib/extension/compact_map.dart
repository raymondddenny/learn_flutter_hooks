extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transoform,
  ]) =>
      map(transoform ?? (e) => e).where((e) => e != null).cast();
}
