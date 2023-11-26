import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_error_message_component.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_loading_message_component.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_text_message_component.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_weather_media_message_component.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_weather_record_message_component.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_weather_time_message_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/dto/response/chat/weather/app_chat_weather_record_response_dto.dart';
import 'package:weatherapp_ui/dto/response/chat/weather/app_chat_weather_time_response_dto.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_error_code_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_type_enum.dart';
import 'package:weatherapp_ui/models/app_chat_message_model.dart';

class AppChatContainerComponent extends StatefulWidget {
  final List<AppChatMessageModel> messages;
  final Function()? onResetChat;

  const AppChatContainerComponent({super.key, this.messages = const [], this.onResetChat});

  @override
  State<AppChatContainerComponent> createState() => _AppChatContainerComponentState();
}

class _AppChatContainerComponentState extends State<AppChatContainerComponent> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      return ListView(
          shrinkWrap: true, children: widget.messages.map((e) => _mapChatMessage(context, width, e)).toList());
    });
  }

  Widget _mapChatMessage(BuildContext context, double width, AppChatMessageModel chatMessage) {
    Widget message;
    switch (chatMessage.type) {
      case AppChatMessageTypeEnum.text:
        message = _getChatTextMessage(width, chatMessage);
        break;
      case AppChatMessageTypeEnum.loading:
        message = _getChatLoadingMessage(width);
        break;
      case AppChatMessageTypeEnum.error:
        message = _getChatErrorMessage(width, chatMessage);
        break;
      case AppChatMessageTypeEnum.weatherTime:
        message = _getChatWeatherTimeMessage(width, chatMessage);
        break;
      case AppChatMessageTypeEnum.weatherRecord:
        message = _getChatWeatherRecordMessage(width, chatMessage);
        break;
      case AppChatMessageTypeEnum.weatherMedia:
        message = _getChatWeatherMediaMessage(width, chatMessage);
        break;
    }
    return Padding(padding: const EdgeInsets.only(top: AppLayoutConfig.chatMessageSpacing), child: message);
  }

  Widget _getChatTextMessage(double width, AppChatMessageModel chatMessage) {
    return AppChatTextMessageComponent(
      width: width,
      text: chatMessage.content,
      role: chatMessage.role,
    );
  }

  Widget _getChatWeatherTimeMessage(double width, AppChatMessageModel chatMessage) {
    AppChatWeatherTimeResponseDto? weatherTime;
    try {
      weatherTime = AppChatWeatherTimeResponseDto.fromJson(jsonDecode(chatMessage.content ?? ""));
    } catch (ex) {
      log("Can not parse weather time for chat: $ex");
    }
    return AppChatWeatherTimeMessageComponent(width: width, weatherTime: weatherTime);
  }

  Widget _getChatWeatherRecordMessage(double width, AppChatMessageModel chatMessage) {
    AppChatWeatherRecordResponseDto? weatherRecord;
    try {
      weatherRecord = AppChatWeatherRecordResponseDto.fromJson(jsonDecode(chatMessage.content ?? ""));
    } catch (ex) {
      log("Can not parse weather record for chat: $ex");
    }
    return AppChatWeatherRecordMessageComponent(width: width, weatherRecord: weatherRecord);
  }

  Widget _getChatWeatherMediaMessage(double width, AppChatMessageModel chatMessage) {
    return AppChatWeatherMediaMessageComponent(
      width: width,
    );
  }

  Widget _getChatLoadingMessage(double width) {
    return AppChatLoadingMessageComponent(width: width);
  }

  Widget _getChatErrorMessage(double width, AppChatMessageModel chatMessage) {
    AppChatErrorCodeEnum? errorCode =
        AppChatErrorCodeEnum.values.firstWhereOrNull((e) => e.name == chatMessage.content);
    return AppChatErrorMessageComponent(width: width, onRestart: widget.onResetChat, errorCode: errorCode);
  }
}
