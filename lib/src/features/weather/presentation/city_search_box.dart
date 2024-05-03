import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/src/constants/app_colors.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';

class CitySearchBox extends ConsumerStatefulWidget {
  const CitySearchBox({super.key});
  @override
  ConsumerState<CitySearchBox> createState() => _CitySearchRowState();
}

class _CitySearchRowState extends ConsumerState<CitySearchBox> {
  static const _radius = 30.0;

  late final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(cityProvider);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // circular radius
  @override
  Widget build(BuildContext context) {
    // final cityName = ref.watch(cityProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: _radius * 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_radius),
                      bottomLeft: Radius.circular(_radius),
                    ),
                  ),
                ),
                onSubmitted: (value) =>
                    ref.read(cityProvider.notifier).state = value,
              ),
            ),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(_radius),
                    bottomRight: Radius.circular(_radius),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text('search',
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
              onTap: () {
                FocusScope.of(context).unfocus();
                ref.read(cityProvider.notifier).state = _searchController.text;
              },
            )
          ],
        ),
      ),
    );
  }
}

final counterProvider = StateProvider<int>((ref) => 0);

class TestCounterProvider extends ConsumerWidget {
  const TestCounterProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return const Placeholder();

    final value = ref.watch(counterProvider);
    return ElevatedButton(
        onPressed: () {
          ref.read(counterProvider.notifier).state++;
        },
        child: Text(value.toString()));
  }
}

/// Notifier

class Counter extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

//  Create a provider for class above
final counterProvider2 = NotifierProvider<Counter, int>(() {
  return Counter();
});
// other waay
final counterProvider3 = NotifierProvider<Counter, int>(Counter.new);

///
///

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController() : super(const AsyncData(null));

  void signInAnomymously() {
    // read the repo using ref

    // set loading state

    // sign in and update state (data or error)
    // state = await AsyncValue.guard(() => authRepo.signInAnonymously);
  }
}

/// Provider Container
final preferencesProvider = Provider<Preferences>((ref) => Preferences());

class Preferences {
  final userId = "user_id";
  // final storage = const FlutterSecureStorage();

  Future<void> setUserId(String value) async {
    // await storage.write(key: userId, value: value);
  }

  Future<String?> getUserId() async {
    // String value = await storage.read(key: userId) ?? '';
    // return value;
    return '';
  }
}

final container = ProviderContainer();

final preferenceData = container.read(preferencesProvider);

final userId = preferenceData.getUserId();

/// END Provider Container
///
///
///
class ReturnData {
  final String test;

  ReturnData(this.test);
}

class AuthRepository {
  Future<ReturnData> signIn({required int movieId}) async {
    return ReturnData('');
  }
}

final authRepoProvider = Provider<AuthRepository>((ref) => AuthRepository());

class AuthControllerCopy extends StateNotifier<AsyncValue<void>> {
  AuthControllerCopy(this.ref) : super(const AsyncData(null));

  final Ref ref;

  Future<void> signInAnomymously() async {
    final provider = ref.watch(authRepoProvider);
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => provider.signIn(movieId: 1));
  }
}
