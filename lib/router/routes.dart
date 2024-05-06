import 'package:flutter/widgets.dart';
import 'package:open_weather_example_flutter/router/route_path.dart';
import 'package:open_weather_example_flutter/src/features/login/presentation/login_page.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_page.dart';

typedef RouteType = Widget Function(BuildContext, RouteSettings);

class Routes {
  Map<String, RouteType> getRouteLogins() {
    return {
      RoutePaths.launch: (c, settings) {
        return const SizedBox();
      }
    };
  }

  Map<String, RouteType> getRoute() {
    return {
      '/': (_, __) => const WeatherPage(),
      RoutePaths.loginPage: (_, __) => const LoginPage(),
    };
  }
}
