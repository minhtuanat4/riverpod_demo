import 'dart:ui';

extension ColorShades on Color {
  Color darker() {
    const darkness = 10;
    final r = (red - darkness).clamp(0, 255).toInt();
    final g = (green - darkness).clamp(0, 255).toInt();
    final b = (blue - darkness).clamp(0, 255).toInt();
    return Color.fromRGBO(r, g, b, 1);
  }
}
