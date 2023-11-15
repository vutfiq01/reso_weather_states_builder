import 'package:flutter/material.dart';
import 'package:reso_weather_states_builder/data/weather_repository.dart';
import 'package:reso_weather_states_builder/pages/weather_search_page.dart';
import 'package:reso_weather_states_builder/state/weather_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

final weatherStore =
    RM.inject<WeatherStore>(() => WeatherStore(FakeWeatherRepository()));

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: StateBuilder<WeatherStore>(
        observe: () => weatherStore,
        builder: (context, weatherStoreRM) {
          return const WeatherSearchPage();
        },
      ),
    );
  }
}
