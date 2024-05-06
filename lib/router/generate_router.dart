import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/common/model_route_popup.dart';
import 'package:open_weather_example_flutter/common/user_management.dart';
import 'package:open_weather_example_flutter/router/routes.dart';

// ignore: avoid_classes_with_only_static_members
class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final routes = Routes().getRoute();
    final child = routes[settings.name];
    final nameRoute = settings.name ?? '';
    //Log ra routeName để tiện theo dõi điều hướng

    if (child != null) {
      var fullscreenDialog = false;

      return Platform.isIOS
          ? MaterialPageRoute(
              settings: RouteSettings(name: nameRoute),
              fullscreenDialog: fullscreenDialog,
              builder: (c) => child(c, settings))
          : MaterialPageRoute(
              settings: RouteSettings(name: nameRoute),
              builder: (c) => child(c, settings));
    } else {
      return defaultRoute();
    }
  }

  static Route<dynamic> defaultRoute() {
    return ModalRoutePopup.showPopup(
      UserManagement().navigatorKey!.currentContext,
      Center(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          padding: const EdgeInsets.only(left: 16, right: 16),
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 5),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Thông báo',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Tính năng đang trong quá trình phát triển.',
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: () {},
                child: const Text('Đóng'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
