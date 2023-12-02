import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_icon_text_button_component.dart';
import 'package:weatherapp_ui/components/chat/message/app_chat_message_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
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
            Text(_getErrorText(context),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: AppLayoutConfig.defaultTextHeadlineFontSize, color: Theme.of(context).colorScheme.error)),
            Padding(
              padding: const EdgeInsets.only(top: AppLayoutConfig.defaultSpacing),
              child: AppIconTextButtonComponent(
                  text: AppL18nConfig.get(context).chat_assistant_retry,
                  type: AppButtonTypeEnum.secondary,
                  icon: Icons.restart_alt,
                  onTap: () => onRestart?.call()),
            )
          ],
        ));
  }

  String _getErrorText(BuildContext context) {
    switch (errorCode) {
      case AppChatErrorCodeEnum.assistant00001:
        return AppL18nConfig.get(context).chat_assistant_error_timeout;
      case AppChatErrorCodeEnum.assistant00002:
        return AppL18nConfig.get(context).chat_assistant_error_data_processing;
      case AppChatErrorCodeEnum.assistant00004:
        return AppL18nConfig.get(context).chat_assistant_error_too_many_requests;
      case AppChatErrorCodeEnum.assistant00003:
      default:
        return AppL18nConfig.get(context).chat_assistant_error_connection_failure;
    }
  }
}
