import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModalRoutePopup extends ModalRoute {
  double? top;
  double? bottom;
  double? left;
  double? right;
  Color? bgColor;
  final Widget child;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => bgColor ?? Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => false;

  ModalRoutePopup({
    required this.child,
    this.bgColor,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    top ??= 10;
    bottom ??= 20;
    left ??= 20;
    right ??= 20;

    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Material(
        // This makes sure that text and other content follows the material style
        type: MaterialType.transparency,
        //type: MaterialType.canvas,
        // make sure that the overlay content is not cut off
        child: SafeArea(
          bottom: true,
          child: _buildOverlayContent(context),
        ),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    const begin = Offset(0, 1);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end);
    final offsetAnimation = animation!.drive(tween);
    return Container(
      margin: EdgeInsets.only(
          bottom: bottom!, left: left!, right: right!, top: top!),
      child: SlideTransition(position: offsetAnimation, child: child),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }

  static Route<dynamic> showPopup(BuildContext? context, Widget widget,
      {BuildContext? popupContext}) {
    return ModalRoutePopup(
      child: PopupContent(
        content: Scaffold(
          backgroundColor: Colors.transparent,
          body: widget,
        ),
      ),
    );
  }
}

class PopupContent extends StatefulWidget {
  final Widget? content;

  const PopupContent({
    super.key,
    this.content,
  });

  @override
  _PopupContentState createState() => _PopupContentState();
}

class _PopupContentState extends State<PopupContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.content,
    );
  }
}
