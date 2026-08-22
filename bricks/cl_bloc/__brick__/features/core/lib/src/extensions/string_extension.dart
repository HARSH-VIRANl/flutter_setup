extension StringTrim on String {
  bool isEmptyWithTrim() => trim().isEmpty;

  bool isNotEmptyWithTrim() => trim().isNotEmpty;
}
