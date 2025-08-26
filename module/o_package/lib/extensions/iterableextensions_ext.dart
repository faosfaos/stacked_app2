extension IterableExtensions<T> on Iterable<T> {
  ///### Koşula uyan ilk elementi döndürür, bulamazsa null döndürür.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (T element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  ///### İlk elementi döndürür, liste boşsa null
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      return iterator.current;
    }
    return null;
  }

  ///### Son elementi döndürür, liste boşsa null
  T? get lastOrNull {
    if (isEmpty) return null;
    return last;
  }

  ///### Tek element varsa onu döndürür, yoksa veya birden fazla varsa null
  T? get singleOrNull {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return null;
    final result = iterator.current;
    if (iterator.moveNext()) return null;
    return result;
  }
}
