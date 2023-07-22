import 'package:weatherapp_ui/enums/app_weather_sort_enum.dart';

class AppWeatherFilterModel {
  AppWeatherSortEnum sort;
  String? startDate;
  String? endDate;
  String? year;

  AppWeatherFilterModel(
      {this.startDate,
      this.endDate,
      this.year,
      this.sort = AppWeatherSortEnum.LATEST});
}
