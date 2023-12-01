import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_role_enum.dart';

class AppChatMessageComponent extends StatelessWidget {
  final Widget? child;
  final AppChatMessageRoleEnum role;
  final double width;

  const AppChatMessageComponent({super.key, this.child, required this.width, this.role = AppChatMessageRoleEnum.user});

  @override
  Widget build(BuildContext context) {
    bool isUserRole = role == AppChatMessageRoleEnum.user;
    return Row(
      mainAxisAlignment: isUserRole ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width * 0.9),
          child: Container(
            decoration: _getBoxDecoration(context, isUserRole),
            child: Padding(padding: const EdgeInsets.all(AppLayoutConfig.defaultSpacing), child: child),
          ),
        )
      ],
    );
  }

  BoxDecoration _getBoxDecoration(BuildContext context, bool isUserRole) {
    return BoxDecoration(
        color: isUserRole ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(AppLayoutConfig.defaultBorderRadius),
            bottomRight: const Radius.circular(AppLayoutConfig.defaultBorderRadius),
            topLeft: Radius.circular(isUserRole ? AppLayoutConfig.defaultBorderRadius : 0),
            topRight: Radius.circular(isUserRole ? 0 : AppLayoutConfig.defaultBorderRadius)));
  }
}
