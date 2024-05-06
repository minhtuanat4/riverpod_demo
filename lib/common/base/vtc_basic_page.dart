import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/common/base/vtc_stateful_page.dart';

mixin VTCBasicPageChild<Page extends VTCStatefulPageChild>
    on VTCStatefulPageStateChild<Page> {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    //isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: WillPopScope(
        onWillPop: isNeedCheckOnWillPop()
            ? Platform.isIOS
                ? onWillPopIOS
                : onWillPop
            : defaultOnWillPop,
        child: Scaffold(
          backgroundColor: isTransparentBackGroundColor()
              ? Colors.transparent
              : backgroundColor(),
          resizeToAvoidBottomInset: resizeToAvoidBottomPadding(),
          key: scaffoldKey,
          appBar: appBar(context) as PreferredSizeWidget?,
          body: body(context),
          floatingActionButton: floatingButtons(),
        ),
      ),
    );
  }

  Future<bool> defaultOnWillPop() {
    return Future.value(true);
  }

  Widget? appBar(BuildContext context);
  Widget? body(BuildContext context);
  Widget fab() => const SizedBox();
  Widget floatingButtons() => const SizedBox();
  bool resizeToAvoidBottomPadding() => true;

  bool isNeedCheckOnWillPop() => false;

  bool isTransparentBackGroundColor() => false;

  Color? backgroundColor() => null;

  ///gọi trước khi màn hình bị pop, khi overrid hàm này thì fai override isNeddCheckOnWillPop, return true
  Future<bool> onWillPop() => Future.value(false);
  Future<bool> onWillPopIOS() => Future.value(false);
}

mixin VTCBasicPage<Page extends VTCStatefulPage> on VTCStatefulPageState<Page> {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    //isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: WillPopScope(
        onWillPop: isNeedCheckOnWillPop()
            ? Platform.isIOS
                ? onWillPopIOS
                : onWillPop
            : defaultOnWillPop,
        child: Scaffold(
          backgroundColor: isTransparentBackGroundColor()
              ? Colors.transparent
              : backgroundColor(),
          resizeToAvoidBottomInset: resizeToAvoidBottomPadding(),
          key: scaffoldKey,
          appBar: appBar(context) as PreferredSizeWidget?,
          body: body(context),
          floatingActionButton: floatingButtons(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  Future<bool> defaultOnWillPop() {
    return Future.value(true);
  }

  Widget? appBar(BuildContext context);
  Widget? body(BuildContext context);
  Widget fab() => const SizedBox();
  Widget floatingButtons() => const SizedBox();
  bool resizeToAvoidBottomPadding() => true;

  bool isNeedCheckOnWillPop() => false;

  bool isTransparentBackGroundColor() => false;

  Color? backgroundColor() => null;

  ///gọi trước khi màn hình bị pop, khi overrid hàm này thì fai override isNeddCheckOnWillPop, return true
  Future<bool> onWillPop() => Future.value(false);
  Future<bool> onWillPopIOS() => Future.value(false);
}
