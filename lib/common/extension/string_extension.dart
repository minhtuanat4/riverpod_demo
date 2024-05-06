extension NumberParsing on String {
  int toInt() {
    return int.parse(this);
  }

  double toDouble() {
    return double.parse(this);
  }

  String uriEncode() {
    return Uri.encodeFull(this);
  }

  // String formatMoney(
  //   int number, {
  //   String format = '#,###',
  //   String locationlize = 'vi_VN',
  // }) {
  //   return NumberFormat(format, locationlize).format(number).toString();
  // }

  bool containsHtml() {
    //final exp = RegExp(r'.*\\<[^>]+\\>.*');
    //return exp.hasMatch(this);
    return startsWith('<');
  }

  /// check a string is numeric
  /// false   // null
  /// false   // ''
  /// false   // 'x'
  /// false   // '123x'
  /// true    // '123'
  /// true    // '+123'
  /// true    // '123.456'
  /// false   // '1,234.567'
  /// false   // '1.234,567' (would be a valid number in Austria/Germany/...)
  /// true    // '-123'
  /// false   // 'INFINITY'
  /// true    // double.INFINITY.toString()
  /// true    // double.NAN.toString()
  /// false   // '0x123'
  bool isNumeric() {
    return double.tryParse(this) != null;
  }
}
