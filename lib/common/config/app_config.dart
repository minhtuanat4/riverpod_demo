import 'package:flutter/cupertino.dart';
import 'package:open_weather_example_flutter/common/resource/definition.dart';

// class AppConfig {
//   late String _appTitle;
//   String get appTitle => _appTitle;
//   late String _buildFlavor;
//   String get buildFlavor => _buildFlavor;
//   late String _vtcEPosUrl;
//   String get vtcEposUrl => _vtcEPosUrl;
//   late String _vtcPayUrl;
//   String get vtcPayUrl => _vtcPayUrl;
//   late String _oneSignalAppId;
//   String get oneSignalAppId => _oneSignalAppId;

//   // true: show, false: not show
//   late bool _showLogApi;
//   bool get showLogApi => _showLogApi;

//   void init({
//     required String appTitle,
//     required String vtcPayUrl,
//     required String vtcPayFollowUrl,
//     required String vtcWebUrl,
//     required String buildFlavor,
//     String oneSignalAppId = '4f1d8857-cd55-4bff-b6f7-092f1f6810c7',
//     int storeConfig = 2,
//     bool showLogApi = true,
//     bool linkGooglePayment = false,
//   }) {
//     _appTitle = appTitle;
//     _vtcEPosUrl = vtcPayUrl;
//     _buildFlavor = buildFlavor;
//     _showLogApi = showLogApi;
//     _oneSignalAppId = oneSignalAppId;
//   }

//   void alpha() {
//     _appTitle = 'VTCPos Alpha';
//     _buildFlavor = 'Alpha';
//     _vtcEPosUrl = baseEPosUrlAlpha;
//     _vtcPayUrl = baseVTCPayUrlAlpha;
//     _oneSignalAppId = '22ce0265-89cb-44b7-b84d-9615df24c22d';
//   }

//   void beta() {
//     _appTitle = 'VTCPos Beta';
//     _buildFlavor = 'Beta';
//     _vtcEPosUrl = baseEposUrlBeta;
//     _vtcPayUrl = baseVTCPayUrlBeta;
//     _oneSignalAppId = '4f1d8857-cd55-4bff-b6f7-092f1f6810c7';
//   }

//   void prod() {
//     _appTitle = 'VTCPos';
//     _buildFlavor = 'Production';
//     _vtcEPosUrl = baseEposUrlProd;
//     _vtcPayUrl = baseVTCPayUrlProd;
//     _oneSignalAppId = '4f1d8857-cd55-4bff-b6f7-092f1f6810c7';
//   }
// }

class AppConfig extends InheritedWidget {
  const AppConfig({
    super.key,
    required super.child,
    required this.appTitle,
    required this.vtcEPosUrl,
    this.checkBackgroundGarenaCard = 'theso',
    this.checkBackgroundFuntapCard = 'funtap',
    this.storeConfig = 2,
    this.linkGooglePayment = false,
    this.showLogApi = true,
  });

  final String appTitle;
  final String vtcEPosUrl;
  final String checkBackgroundGarenaCard;
  final String checkBackgroundFuntapCard;

  ///0 - All, 1 - AppleStore, 2 - GooglePlay, 3 - HuaweiStore, 4 - SamsungStore, 5 - Oppo, 6 - Vivo, 7 - Xiaomi
  final int storeConfig;
  final bool linkGooglePayment;
  // true: show, false: not show
  final bool showLogApi;

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
