import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_message_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_role_enum.dart';

class AppChatTextMessageComponent extends StatelessWidget {
  final String? text;
  final AppChatMessageRoleEnum role;
  final double width;

  const AppChatTextMessageComponent(
      {super.key, this.text, required this.width, this.role = AppChatMessageRoleEnum.user});

  @override
  Widget build(BuildContext context) {
    bool isUserRole = role == AppChatMessageRoleEnum.user;
    return AppChatMessageComponent(
        width: width,
        role: role,
        child: Text(text ?? "",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: AppLayoutConfig.defaultTextHeadlineFontSize,
                color: isUserRole
                    ? Theme.of(context).colorScheme.onTertiary.withOpacity(0.9)
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.9))));
  }
}
