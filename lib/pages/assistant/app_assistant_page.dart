import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/chat/container/app_chat_container_component.dart';
import 'package:weatherapp_ui/components/input/app_prompt_input_component.dart';
import 'package:weatherapp_ui/components/scaffold/app_scaffold_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/providers/assistant/app_assistant_provider.dart';

class AppAssistantPage extends StatelessWidget {
  const AppAssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldComponent(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(AppL18nConfig.get(context).page_assistant),
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppLayoutConfig.pageAssistantSpacing),
      child: Consumer<AppAssistantProvider>(builder: (context, provider, widget) {
        return Column(
          children: [_getChatContainer(context, provider), _getChatInput(context, provider)],
        );
      }),
    );
  }

  Widget _getChatContainer(BuildContext context, AppAssistantProvider assistantProvider) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: AppLayoutConfig.pageAssistantSpacing),
          child: AppChatContainerComponent(
            onResetChat: () => assistantProvider.clearChat(),
            messages: assistantProvider.chatMessages,
          ),
        ),
      ),
    );
  }

  Widget _getChatInput(BuildContext context, AppAssistantProvider assistantProvider) {
    return AppPromptInputComponent(
        hint: AppL18nConfig.get(context).chat_assistant_type_message,
        disabled: assistantProvider.isLoading || assistantProvider.hasError,
        onTextSent: (t) => assistantProvider.sendChatMessage(t));
  }
}
