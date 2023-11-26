import 'package:flutter/material.dart';
import 'package:weatherapp_ui/dto/response/chat/weather/app_chat_weather_record_response_dto.dart';

class AppChatWeatherRecordMessageComponent extends StatelessWidget {
  final double width;
  final AppChatWeatherRecordResponseDto? weatherRecord;

  const AppChatWeatherRecordMessageComponent({super.key, required this.width, this.weatherRecord});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
