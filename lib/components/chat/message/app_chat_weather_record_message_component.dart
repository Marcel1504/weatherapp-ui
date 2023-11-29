import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_message_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/dto/response/chat/weather/app_chat_weather_record_response_dto.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_role_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_weather_aggregation_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_weather_record_enum.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppChatWeatherRecordMessageComponent extends StatelessWidget {
  final double width;
  final AppChatWeatherRecordResponseDto? weatherRecord;

  const AppChatWeatherRecordMessageComponent({super.key, required this.width, this.weatherRecord});

  @override
  Widget build(BuildContext context) {
    return AppChatMessageComponent(
      width: width,
      role: AppChatMessageRoleEnum.function,
      child: Column(
        children: [_station(context), _date(context), _mainValue(context)],
      ),
    );
  }

  Widget _station(BuildContext context) {
    return Text(
      " ${weatherRecord!.station!}",
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _date(BuildContext context) {
    String datePattern;
    switch (weatherRecord?.aggregation) {
      case AppChatWeatherAggregationEnum.month:
        datePattern = AppTimeService.prettyMonthPattern;
        break;
      case AppChatWeatherAggregationEnum.year:
        datePattern = AppTimeService.prettyYearPattern;
        break;
      case AppChatWeatherAggregationEnum.day:
      default:
        datePattern = AppTimeService.prettyDayPattern;
        break;
    }
    return Padding(
      padding: const EdgeInsets.only(
          top: AppLayoutConfig.chatMessageContentSpacing, bottom: AppLayoutConfig.chatMessageContentSpacing),
      child: Text(
        AppTimeService().transformISODayString(context, weatherRecord?.date, pattern: datePattern) ?? "?",
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 18),
      ),
    );
  }

  Widget _mainValue(BuildContext context) {
    switch (weatherRecord?.type) {
      case AppChatWeatherRecordEnum.coldest:
        return _mainValueText(context, "${weatherRecord?.temperatureMin} °C",
            AppColorService().temperatureToColor(context, weatherRecord?.temperatureMin));
      case AppChatWeatherRecordEnum.mostRain:
        return _mainValueText(context, "${weatherRecord?.rainTotal} l/m²", const Color.fromRGBO(0, 175, 255, 1));
      case AppChatWeatherRecordEnum.strongestWind:
        return _mainValueText(context, "${weatherRecord?.windMax} km/h", const Color.fromRGBO(111, 111, 111, 1));
      case AppChatWeatherRecordEnum.hottest:
      default:
        return _mainValueText(context, "${weatherRecord?.temperatureMax} °C",
            AppColorService().temperatureToColor(context, weatherRecord?.temperatureMax));
    }
  }

  Widget _mainValueText(BuildContext context, String? text, Color color) {
    return Text(
      text ?? "?",
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
          fontSize: 25, color: Color.alphaBlend(color.withOpacity(0.7), Theme.of(context).colorScheme.onSurface)),
    );
  }
}
