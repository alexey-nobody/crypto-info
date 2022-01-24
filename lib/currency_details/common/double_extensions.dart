extension DoubleExtensions on double {
  String toStringWithoutTrailingZeros() {
    return truncateToDouble() == this ? toInt().toString() : toString();
  }
}
