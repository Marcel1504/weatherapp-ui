import 'package:flutter/material.dart';
import 'package:weatherapp_ui/dto/response/chat/weather/app_chat_weather_time_response_dto.dart';

class AppChatWeatherMediaMessageComponent extends StatelessWidget {
  final double width;
  final AppChatWeatherTimeResponseDto? weatherTime;

  const AppChatWeatherMediaMessageComponent({super.key, required this.width, this.weatherTime});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
