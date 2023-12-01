import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/chat/container/app_chat_container_component.dart';
import 'package:weatherapp_ui/components/dialog/assistant/app_assistant_disclaimer_dialog.dart';
import 'package:weatherapp_ui/components/input/app_prompt_input_component.dart';
import 'package:weatherapp_ui/components/scaffold/app_scaffold_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/fragments/assistant/app_assistant_options_fragment.dart';
import 'package:weatherapp_ui/providers/assistant/app_assistant_provider.dart';
import 'package:weatherapp_ui/services/configuration/app_configuration_service.dart';

class AppAssistantPage extends StatefulWidget {
  const AppAssistantPage({super.key});

  @override
  State<AppAssistantPage> createState() => _AppAssistantPageState();
}

class _AppAssistantPageState extends State<AppAssistantPage> {
  @override
  void initState() {
    AppConfigurationService().getAssistantDisclaimerShown().then((shown) {
      if (!(shown ?? true)) {
        showDialog(
            context: context, barrierDismissible: false, builder: (context) => const AppAssistantDisclaimerDialog());
      }
    });
    super.initState();
  }

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
      titleTextStyle:
          Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
    );
  }

  Widget _body(BuildContext context) {
    return Consumer<AppAssistantProvider>(builder: (context, provider, widget) {
      return Column(
        children: [
          provider.chatMessages.isNotEmpty ? _getChatContainer(provider) : _getOptions(provider),
          _getCoolDownText(provider),
          _getChatInput(provider)
        ],
      );
    });
  }

  Widget _getChatContainer(AppAssistantProvider assistantProvider) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: AppLayoutConfig.defaultSpacing),
          child: AppChatContainerComponent(
              onResetChat: () => assistantProvider.clearChat(),
              messages: assistantProvider.chatMessages,
              sideSpacing: AppLayoutConfig.defaultSpacing),
        ),
      ),
    );
  }

  Widget _getOptions(AppAssistantProvider assistantProvider) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppLayoutConfig.defaultSpacing),
        child: AppAssistantOptionsFragment(optionSelected: (o) {
          if (assistantProvider.canSendMessage()) {
            assistantProvider.sendChatMessage(context, o);
          }
        }),
      ),
    );
  }

  Widget _getCoolDownText(AppAssistantProvider assistantProvider) {
    return assistantProvider.currentCoolDownSeconds <= 0
        ? Container()
        : Padding(
      padding: const EdgeInsets.only(top: AppLayoutConfig.defaultSpacing),
            child: Text(
              AppL18nConfig.get(context).chat_assistant_wait(assistantProvider.currentCoolDownSeconds),
              style: Theme.of(context).textTheme.labelMedium,
            ),
          );
  }

  Widget _getChatInput(AppAssistantProvider assistantProvider) {
    return Padding(
      padding: const EdgeInsets.all(AppLayoutConfig.defaultSpacing),
      child: AppPromptInputComponent(
          hint: AppL18nConfig.get(context).chat_assistant_type_message,
          disabled: !assistantProvider.canSendMessage(),
          onTextSent: (t) => assistantProvider.sendChatMessage(context, t)),
    );
  }

  @override
  void deactivate() {
    Provider.of<AppAssistantProvider>(context, listen: false).clearChat(notify: false);
    super.deactivate();
  }
}
