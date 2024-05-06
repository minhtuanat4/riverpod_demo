import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/common/resource/definition_color.dart';

mixin VTCStatefulAlertVTCPay {
  ///Return Appbar
  ///[actions] not null => use actions, == null => use [isEnableCloseButton]
  static AppBar appBarCustom({
    required BuildContext context,
    String? title,
    bool isEnableBackButton = true,
    bool isEnableCloseButton = false,
    bool isEnableShopCartButton = false,
    double elevation = 0,
    Widget? bottom,
    double titleFontSize = 20,
    List<Widget>? actions,
    Color? backgroundColor,
    Widget? leading,
    Color? shadowColor,
    VoidCallback? onClosePressed,
    VoidCallback? onBackPressed,
  }) {
    if (isEnableBackButton) {
      return AppBar(
        leading: leading ??
            BackButton(
                onPressed: onBackPressed ??
                    () {
                      Navigator.of(context).pop();
                    }),
        titleSpacing: 0,
        backgroundColor: backgroundColor ?? Colors.white,
        elevation: elevation,
        shadowColor: shadowColor,
        centerTitle: true,
        title: Center(
          child: Text(
            title ?? '',
            style:
                TextStyle(color: Colors.grey.shade700, fontSize: titleFontSize),
          ),
        ),
        iconTheme: const IconThemeData(
          color: colorGrey700,
        ),
        actions: actions ??
            <Widget>[
              if (isEnableCloseButton)
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[700],
                  ),
                  onPressed: onClosePressed ??
                      () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                )
              else
                const SizedBox(width: 10)
              // IgnorePointer(
              //   child: IconButton(
              //     icon: const Icon(Icons.close, color: Colors.transparent),
              //     onPressed: () {},
              //   ),
              // )
            ],
        bottom: bottom as PreferredSizeWidget?,
      );
    } else {
      return AppBar(
        leading: const SizedBox(),
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title!,
          style: TextStyle(
            color: colorGrey700,
            fontSize: titleFontSize,
          ),
        ),
        iconTheme: const IconThemeData(color: colorGrey700),
        actions: actions ??
            <Widget>[
              if (isEnableCloseButton)
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[700],
                  ),
                  onPressed: onClosePressed ??
                      () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                )
              else
                const SizedBox()
            ],
      );
    }
  }

  static void showErrorSnackbar({
    required String? message,
    required GlobalKey<ScaffoldState> scaffoldKey,
    ScaffoldState? context,
    int duration = 2,
  }) {
    if (message != null) {
      if (context == null) {
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
          SnackBar(
            duration: Duration(seconds: duration),
            content: Text(
              message,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context.context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: duration),
            content: Text(
              message,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }
    }
  }
}
