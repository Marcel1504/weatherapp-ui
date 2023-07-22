import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/response/station/app_station_response_dto.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/enums/app_station_type_enum.dart';
import 'package:weatherapp_ui/fragments/loading/app_loading_fragment.dart';
import 'package:weatherapp_ui/providers/data/summary/app_summary_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/day/app_soil_day_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/day/app_weather_day_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/month/app_soil_month_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/month/app_weather_month_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/year/app_soil_year_data_provider.dart';
import 'package:weatherapp_ui/providers/data/summary/year/app_weather_year_data_provider.dart';

class AppReviewDataListFragment extends StatefulWidget {
  final AppStationResponseDto? station;
  final AppCalendarEnum? type;

  const AppReviewDataListFragment({super.key, this.station, this.type});

  @override
  State<AppReviewDataListFragment> createState() =>
      _AppReviewDataListFragmentState();
}

class _AppReviewDataListFragmentState extends State<AppReviewDataListFragment> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      ScrollPosition position = _scrollController.position;
      if (position.atEdge && position.pixels != 0) {
        _getProvider()?.loadNext();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _getProvider()?.loadInitialByStationCode(widget.station?.code);
    return _root();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _root() {
    if (widget.station?.type == AppStationTypeEnum.WEATHER) {
      return _getRootWeather();
    }
    if (widget.station?.type == AppStationTypeEnum.SOIL) {
      return _getRootSoil();
    }
    return Container();
  }

  Widget _getRootWeather() {
    switch (widget.type) {
      case AppCalendarEnum.DAY:
        return Consumer<AppWeatherDayDataProvider>(
          builder: (context, provider, widget) {
            return _list(
                context,
                provider.loading,
                provider.data
                    .map((e) => Text(e.day?.toString() ?? "-"))
                    .toList());
          },
        );
      case AppCalendarEnum.MONTH:
        return Consumer<AppWeatherMonthDataProvider>(
          builder: (context, provider, widget) {
            return _list(
                context,
                provider.loading,
                provider.data
                    .map((e) => Text(e.month?.toString() ?? "-"))
                    .toList());
          },
        );
      case AppCalendarEnum.YEAR:
        return Consumer<AppWeatherYearDataProvider>(
          builder: (context, provider, widget) {
            return _list(
                context,
                provider.loading,
                provider.data
                    .map((e) => Text(e.year?.toString() ?? "-"))
                    .toList());
          },
        );
      default:
        return Container();
    }
  }

  Widget _getRootSoil() {
    switch (widget.type) {
      case AppCalendarEnum.DAY:
        return Consumer<AppSoilDayDataProvider>(
          builder: (context, provider, widget) {
            return _list(
                context,
                provider.loading,
                provider.data
                    .map((e) => Text(e.day?.toString() ?? "-"))
                    .toList());
          },
        );
      case AppCalendarEnum.MONTH:
        return Consumer<AppSoilMonthDataProvider>(
          builder: (context, provider, widget) {
            return _list(
                context,
                provider.loading,
                provider.data
                    .map((e) => Text(e.month?.toString() ?? "-"))
                    .toList());
          },
        );
      case AppCalendarEnum.YEAR:
        return Consumer<AppSoilYearDataProvider>(
          builder: (context, provider, widget) {
            return _list(
                context,
                provider.loading,
                provider.data
                    .map((e) => Text(e.year?.toString() ?? "-"))
                    .toList());
          },
        );
      default:
        return Container();
    }
  }

  AppSummaryDataProvider? _getProvider() {
    if (widget.station?.type == AppStationTypeEnum.WEATHER) {
      return _getProviderWeather();
    }
    if (widget.station?.type == AppStationTypeEnum.SOIL) {
      return _getProviderSoil();
    }
    return null;
  }

  AppSummaryDataProvider? _getProviderWeather() {
    switch (widget.type) {
      case AppCalendarEnum.DAY:
        return Provider.of<AppWeatherDayDataProvider>(context, listen: false);
      case AppCalendarEnum.MONTH:
        return Provider.of<AppWeatherMonthDataProvider>(context, listen: false);
      case AppCalendarEnum.YEAR:
        return Provider.of<AppWeatherYearDataProvider>(context, listen: false);
      default:
        return null;
    }
  }

  AppSummaryDataProvider? _getProviderSoil() {
    switch (widget.type) {
      case AppCalendarEnum.DAY:
        return Provider.of<AppSoilDayDataProvider>(context, listen: false);
      case AppCalendarEnum.MONTH:
        return Provider.of<AppSoilMonthDataProvider>(context, listen: false);
      case AppCalendarEnum.YEAR:
        return Provider.of<AppSoilYearDataProvider>(context, listen: false);
      default:
        return null;
    }
  }

  Widget _list(BuildContext context, bool loading, List<Widget> items) {
    return ListView(
      controller: _scrollController,
      children: [
        ...items,
        loading
            ? const AppLoadingFragment(
                size: 20,
              )
            : Container()
      ],
    );
  }
}
