import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_weather_example_flutter/common/debug/debug.dart';
import 'package:open_weather_example_flutter/common/popup/vtc_popup.dart';

abstract class VTCStatefulPageChild extends StatefulWidget {
  const VTCStatefulPageChild({super.key});
}

abstract class VTCStatefulPageStateChild<Page extends VTCStatefulPageChild>
    extends State<Page> {
  bool isShowLogin = false;
  bool isShowLoading = false;
  bool isDarkMode = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showLogin() {
    isShowLogin = true;
    // setState(() {});
  }

  void hideLogin() {
    isShowLogin = false;
    // setState(() {});
  }

  @override
  void initState() {
    Debug.logMessage(
      trace: StackTrace.current,
      message:
          '=====================================Child Screen:${runtimeType.toString()}',
    );

    super.initState();
  }
}

abstract class VTCStatefulPage extends StatefulWidget {
  const VTCStatefulPage({super.key});
}

abstract class VTCStatefulPageState<Page extends VTCStatefulPage>
    extends State<Page> {
  //
  bool isShowLogin = false;
  bool isShowLoading = false;
  bool isDarkMode = false;

  //
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static MethodChannel methodChannel = const MethodChannel('riverpod');
  //

  @override
  void initState() {
    Debug.logMessage(
      trace: StackTrace.current,
      message:
          '=====================================Child Screen:${runtimeType.toString()}',
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showLogin() {
    isShowLogin = true;
    // setState(() {});
  }

  void hideLogin() {
    isShowLogin = false;
    // setState(() {});
  }

  void print(Object message) {
    Debug.logMessage(trace: StackTrace.current, message: message);
  }

  ///Return Appbar
  ///[actions] not null => use actions, == null => use [isEnableCloseButton]
  AppBar appBarCustom({
    String? title,
    bool isEnableBackButton = true,
    bool isEnableCloseButton = false,
    bool isEnableShopCartButton = false,
    double elevation = 0,
    Widget? bottom,
    double titleFontSize = 20,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? shadowColor,
    Widget? leading,
    VoidCallback? onClosePressed,
    VoidCallback? onBackPressed,
  }) {
    return VTCStatefulAlertVTCPay.appBarCustom(
      context: context,
      title: title,
      isEnableBackButton: isEnableBackButton,
      isEnableCloseButton: isEnableCloseButton,
      isEnableShopCartButton: isEnableShopCartButton,
      elevation: elevation,
      bottom: bottom,
      titleFontSize: titleFontSize,
      actions: actions,
      backgroundColor: backgroundColor,
      leading: leading,
      shadowColor: shadowColor,
      onClosePressed: onClosePressed,
      onBackPressed: onBackPressed,
    );
  }

  AppBar appBarCHPlay({
    Color? backgroundColor,
    Widget? leading,
  }) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: leading,
      titleSpacing: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
