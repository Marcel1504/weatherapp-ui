import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_message_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/dto/response/chat/weather/app_chat_weather_time_response_dto.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_role_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_weather_aggregation_enum.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppChatWeatherTimeMessageComponent extends StatelessWidget {
  final double width;
  final AppChatWeatherTimeResponseDto? weatherTime;

  const AppChatWeatherTimeMessageComponent({super.key, required this.width, this.weatherTime});

  @override
  Widget build(BuildContext context) {
    return AppChatMessageComponent(
      width: width,
      role: AppChatMessageRoleEnum.function,
      child: Column(
        children: [_station(context), _date(context), _mainValues(context)],
      ),
    );
  }

  Widget _station(BuildContext context) {
    return Text(
      " ${weatherTime!.station!}",
      style:
          Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
    );
  }

  Widget _date(BuildContext context) {
    String datePattern;
    switch (weatherTime?.aggregation) {
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
      padding: const EdgeInsets.only(top: AppLayoutConfig.defaultSpacing, bottom: AppLayoutConfig.defaultSpacing),
      child: Text(
        AppTimeService().transformISODayString(context, weatherTime?.date, pattern: datePattern) ?? "?",
        style:
            Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
      ),
    );
  }

  Widget _mainValues(BuildContext context) {
    return Column(
      children: [
        _mainValueText(context, AppL18nConfig.get(context).chat_assistant_message_temperature,
            "${weatherTime?.temperature} °C", AppColorService().temperatureToColor(context, weatherTime?.temperature)),
        _mainValueText(context, AppL18nConfig.get(context).chat_assistant_message_wind, "${weatherTime?.windMax} km/h",
            const Color.fromRGBO(111, 111, 111, 1)),
        _mainValueText(context, AppL18nConfig.get(context).chat_assistant_message_rain,
            "${weatherTime?.rainTotal} l/m²", const Color.fromRGBO(0, 175, 255, 1)),
        _mainValueText(context, AppL18nConfig.get(context).chat_assistant_message_humidity, "${weatherTime?.humidity}%",
            Colors.purple),
      ],
    );
  }

  Widget _mainValueText(BuildContext context, String title, String? value, Color color) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppLayoutConfig.chatAssistantWeatherTimeMaxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize)),
          Text(
            value ?? "?",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: AppLayoutConfig.defaultTextHeadlineFontSize,
                color: Color.alphaBlend(color.withOpacity(0.7), Theme.of(context).colorScheme.onSurface)),
          ),
        ],
      ),
    );
  }
}
