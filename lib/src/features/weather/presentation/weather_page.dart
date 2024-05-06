import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/common/base/vtc_basic_page.dart';
import 'package:open_weather_example_flutter/common/base/vtc_stateful_page.dart';
import 'package:open_weather_example_flutter/src/constants/app_colors.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/city_search_box.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/current_weather.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/hourly_weather.dart';

class WeatherPage extends VTCStatefulPage {
  const WeatherPage({
    super.key,
  });

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends VTCStatefulPageState<WeatherPage>
    with VTCBasicPage {
  @override
  Widget body(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.rainGradient,
        ),
      ),
      child: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            CitySearchBox(),
            Spacer(),
            CurrentWeather(),
            Spacer(),
            HourlyWeather(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Widget? appBar(BuildContext context) {
    return appBarCustom();
  }
}
