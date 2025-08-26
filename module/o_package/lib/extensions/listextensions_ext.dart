extension ListExtensions<T> on List<T> {
  ///### Belirtilen [index] 'teki elementi döndürür, [index] geçersizse null
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}
