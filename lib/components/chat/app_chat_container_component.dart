import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/chat/app_chat_error_message_component.dart';
import 'package:weatherapp_ui/components/chat/app_chat_loading_message_component.dart';
import 'package:weatherapp_ui/components/chat/app_chat_text_message_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
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
      case AppChatMessageTypeEnum.weatherData:
        message = _getChatWeatherDataMessage(width, chatMessage);
        break;
      case AppChatMessageTypeEnum.error:
        message = _getChatErrorMessage(width);
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

  Widget _getChatWeatherDataMessage(double width, AppChatMessageModel chatMessage) {
    return AppChatTextMessageComponent(
      width: width,
      text: chatMessage.content,
      role: chatMessage.role,
    );
  }

  Widget _getChatLoadingMessage(double width) {
    return AppChatLoadingMessageComponent(width: width);
  }

  Widget _getChatErrorMessage(double width) {
    return AppChatErrorMessageComponent(
      width: width,
      onRestart: widget.onResetChat,
    );
  }
}
