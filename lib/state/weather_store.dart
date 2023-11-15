import 'package:reso_weather_states_builder/data/model/weather.dart';
import 'package:reso_weather_states_builder/data/weather_repository.dart';

class WeatherStore {
  final WeatherRepository _weatherRepository;

  WeatherStore(this._weatherRepository);

  late Weather _weather;
  Weather get weather => _weather;

  void getWeather(String cityName) async {
    _weather = await _weatherRepository.fetchWeather(cityName);
  }
}
