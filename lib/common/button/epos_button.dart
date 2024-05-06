import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/common/resource/definition_color.dart';

// final btnStyleCircle = ElevatedButton.styleFrom(
//   backgroundColor: Colors.transparent,
//   surfaceTintColor: Colors.transparent,
//   elevation: 1,
//   shadowColor: Colors.grey,
//   foregroundColor: Colors.transparent,
//   visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//   padding: const EdgeInsets.all(0),
//   shape: const CircleBorder(),
// );
// final btnStyleRRectangle = ElevatedButton.styleFrom(
//   backgroundColor: Colors.transparent,
//   surfaceTintColor: Colors.transparent,
//   shadowColor: Colors.grey,
//   elevation: 0,
//   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//   visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//   foregroundColor: Colors.transparent,
//   padding: const EdgeInsets.all(0),
//   shape: const RoundedRectangleBorder(),
// );
// final btnStyleIconCircle = ElevatedButton.styleFrom(
//   shadowColor: Colors.grey,
//   elevation: 0,
//   backgroundColor: Colors.transparent,
//   surfaceTintColor: Colors.transparent,
//   padding: const EdgeInsets.all(0),
//   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//   visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//   shape: const CircleBorder(),
// );
// final btnStyleIconRRectangle = ElevatedButton.styleFrom(
//   shadowColor: Colors.grey,
//   elevation: 0,
//   backgroundColor: Colors.transparent,
//   surfaceTintColor: Colors.transparent,
//   padding: const EdgeInsets.all(0),
//   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//   visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//   shape: const RoundedRectangleBorder(),
// );

enum ButtonStyleEnum {
  CircleShape,
  RRectangle,
}

class EposButtonCustom extends StatelessWidget {
  final ButtonStyleEnum buttonStyleEnum;
  final VoidCallback onPressed;
  final Color fgColor;
  final Color bgColor;
  final Color shadowColor;
  final double? width;
  final double? height;
  final double elevation;
  final double radiusRRectangle;
  final EdgeInsetsGeometry? padding;
  final Alignment? alignmentChild;
  final Widget child;
  final bool isBorder;
  final Color borderColor;

  const EposButtonCustom({
    required this.buttonStyleEnum,
    required this.onPressed,
    required this.child,
    this.fgColor = Colors.black,
    this.bgColor = Colors.transparent,
    this.shadowColor = Colors.transparent,
    this.alignmentChild,
    this.width,
    this.height,
    this.elevation = 0,
    this.radiusRRectangle = 28,
    this.isBorder = false,
    this.padding = const EdgeInsets.symmetric(vertical: 28),
    this.borderColor = colorPayBlack,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final shapeButton = buttonStyleEnum == ButtonStyleEnum.RRectangle
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radiusRRectangle),
            ),
          )
        : const CircleBorder();
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      surfaceTintColor: Colors.transparent,
      shadowColor: shadowColor,
      elevation: elevation,
      alignment: alignmentChild,
      minimumSize: const Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      padding: padding,
      shape: shapeButton,
      side: isBorder ? BorderSide(color: borderColor) : BorderSide.none,
    ).copyWith(
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black12;
          }

          return Colors.black12; // Defer to the widget's default.
        },
      ),
    );
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: child,
        ),
      ),
    );
  }
}
