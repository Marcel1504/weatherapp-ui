import 'package:weatherapp_ui/enums/app_weather_sort_enum.dart';

class AppWeatherFilterModel {
  AppWeatherSortEnum sort;
  String? startDay;
  String? endDay;
  String? year;

  AppWeatherFilterModel(
      {this.startDay,
      this.endDay,
      this.year,
      this.sort = AppWeatherSortEnum.LATEST});
}
