import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/common/config/app_config.dart';
import 'package:open_weather_example_flutter/common/resource/definition.dart';
import 'package:open_weather_example_flutter/common/user_management.dart';
import 'package:open_weather_example_flutter/router/generate_router.dart'
    as vtcrouter;
import 'package:open_weather_example_flutter/src/common/loading_provider.dart';

MaterialColor appBarColor = const MaterialColor(
  0xFF5472c2,
  {
    50: Color(0xFF5472c2),
    100: Color(0xFF5472c2),
    200: Color(0xFF5472c2),
    300: Color(0xFF5472c2),
    400: Color(0xFF5472c2),
    500: Color(0xFF5472c2),
    600: Color(0xFF5472c2),
    700: Color(0xFF5472c2),
    800: Color(0xFF5472c2),
    900: Color(0xFF5472c2),
  },
);

MaterialColor appBarWhiteColor = const MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
void main() {
  const configuredApp = AppConfig(
    appTitle: 'VTCPay',
    vtcEPosUrl: baseEPosUrlAlpha,
    checkBackgroundGarenaCard: 'thegarena',
    checkBackgroundFuntapCard: 'thefuncard',
    linkGooglePayment: true,
    child: MyApp(),
  );
  runApp(const ProviderScope(child: configuredApp));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserManagement().navigatorKey = GlobalKey<NavigatorState>();
    final textStyleWithShadow = TextStyle(color: Colors.white, shadows: [
      BoxShadow(
        color: Colors.black12.withOpacity(0.25),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 0.5),
      )
    ]);
    return MaterialApp(
      title: 'Flutter Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: appBarColor,
        textTheme: TextTheme(
          displayLarge: textStyleWithShadow,
          displayMedium: textStyleWithShadow,
          displaySmall: textStyleWithShadow,
          headlineMedium: textStyleWithShadow,
          headlineSmall: textStyleWithShadow,
          titleMedium: const TextStyle(color: Colors.white),
          bodyMedium: const TextStyle(color: Colors.white),
          bodyLarge: const TextStyle(color: Colors.white),
          bodySmall: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ),
      builder: (context, child) {
        return RootPage(
          oneSignalAppId: 'oneSignalAppId',
          child: child,
        );
      },
      onGenerateRoute: vtcrouter.Router.generateRoute,
    );
  }
}

class RootPage extends StatefulWidget {
  final Widget? child;
  final String oneSignalAppId;
  const RootPage({super.key, this.child, required this.oneSignalAppId});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [widget.child!, const CircularIndicator()],
    );
  }
}

class CircularIndicator extends ConsumerWidget {
  const CircularIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShowLoading = ref.watch(loadingProvider);
    return isShowLoading
        ? Container(
            color: Colors.black.withOpacity(0.2),
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(188),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(22),
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
