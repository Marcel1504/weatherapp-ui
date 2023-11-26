import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_message_component.dart';
import 'package:weatherapp_ui/components/loading/app_loading_component.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_role_enum.dart';

class AppChatLoadingMessageComponent extends StatelessWidget {
  final double width;

  const AppChatLoadingMessageComponent({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return AppChatMessageComponent(
        width: width, role: AppChatMessageRoleEnum.assistant, child: const AppLoadingComponent());
  }
}
