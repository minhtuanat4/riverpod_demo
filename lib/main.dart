import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/src/common/loading_provider.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: const WeatherPage(city: 'London'),
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
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
