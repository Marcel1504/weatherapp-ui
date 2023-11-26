import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_icon_text_button_component.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_message_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_error_code_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_role_enum.dart';

class AppChatErrorMessageComponent extends StatelessWidget {
  final double width;
  final Function()? onRestart;
  final AppChatErrorCodeEnum? errorCode;

  const AppChatErrorMessageComponent({super.key, required this.width, this.onRestart, this.errorCode});

  @override
  Widget build(BuildContext context) {
    return AppChatMessageComponent(
        width: width,
        role: AppChatMessageRoleEnum.assistant,
        child: Column(
          children: [
            Text("An error occurred while processing your message. Please restart the chat",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: AppLayoutConfig.chatMessageFontSize, color: Theme.of(context).colorScheme.error)),
            Padding(
              padding: const EdgeInsets.only(top: AppLayoutConfig.chatMessageContentSpacing),
              child: AppIconTextButtonComponent(
                  text: "Restart",
                  type: AppButtonTypeEnum.secondary,
                  icon: Icons.restart_alt,
                  onTap: () => onRestart?.call()),
            )
          ],
        ));
  }
}
