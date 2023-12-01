import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/request/chat/app_chat_request_dto.dart';
import 'package:weatherapp_ui/dto/response/chat/app_chat_response_dto.dart';
import 'package:weatherapp_ui/dto/response/chat/message/app_chat_message_response_dto.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_role_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_type_enum.dart';
import 'package:weatherapp_ui/models/app_chat_message_model.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/backend/assistant/app_assistant_backend_service.dart';

class AppAssistantProvider extends ChangeNotifier {
  final AppAssistantBackendService _backendService = AppAssistantBackendService();
  final List<AppChatMessageModel> _chatMessages = [];
  int? _chatId;
  bool _isLoading = false;
  bool _hasError = false;
  Timer? _coolDownTimer;
  int _currentCoolDownSeconds = 0;

  Future<void> sendChatMessage(BuildContext context, String? message) async {
    if (message != null && canSendMessage()) {
      _isLoading = true;
      notifyListeners();

      // get context station
      String? stationCode = Provider.of<AppStationProvider>(context, listen: false).selectedStation?.code;

      // add new message to chatMessage and also the loading indicator message
      _chatMessages.add(
          AppChatMessageModel(role: AppChatMessageRoleEnum.user, type: AppChatMessageTypeEnum.text, content: message));
      _chatMessages
          .add(AppChatMessageModel(role: AppChatMessageRoleEnum.assistant, type: AppChatMessageTypeEnum.loading));

      // perform request with the chat message
      AppChatRequestDto chatRequest =
          AppChatRequestDto(message: message, chatId: _chatId, contextStationCode: stationCode);
      AppChatResponseDto chatResponse = await _backendService.sendChatMessage(chatRequest);
      _chatId = chatResponse.chatId;

      // remove loading message once the chat request is finished
      _chatMessages.removeWhere((m) => m.type == AppChatMessageTypeEnum.loading);

      // handle the chat response
      for (AppChatMessageResponseDto message in chatResponse.messages ?? []) {
        message.type == AppChatMessageTypeEnum.error ? _handleErrorMessage(message) : _handleChatMessage(message);
      }

      _isLoading = false;
      _startCoolDownTimer();
      notifyListeners();
    }
  }

  void clearChat({bool notify = true}) {
    _chatMessages.clear();
    _chatId = null;
    _hasError = false;
    _isLoading = false;
    if (notify) {
      notifyListeners();
    }
  }

  bool canSendMessage() {
    return !_isLoading && !_hasError && _currentCoolDownSeconds <= 0;
  }

  void _handleChatMessage(AppChatMessageResponseDto message) {
    AppChatMessageRoleEnum? role = message.role ?? AppChatMessageRoleEnum.assistant;
    AppChatMessageTypeEnum type = message.type ?? AppChatMessageTypeEnum.text;
    _chatMessages.add(AppChatMessageModel(role: role, type: type, content: message.content));
  }

  void _handleErrorMessage(AppChatMessageResponseDto message) {
    _hasError = true;
    _chatMessages.add(AppChatMessageModel(
        role: AppChatMessageRoleEnum.assistant, type: AppChatMessageTypeEnum.error, content: message.content));
  }

  void _startCoolDownTimer() {
    if (_coolDownTimer != null) {
      _coolDownTimer?.cancel();
    }
    _currentCoolDownSeconds = 20;
    _coolDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentCoolDownSeconds--;
      if (_currentCoolDownSeconds <= 0) {
        timer.cancel();
        _coolDownTimer == null;
      }
      notifyListeners();
    });
  }

  List<AppChatMessageModel> get chatMessages => _chatMessages;

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  int get currentCoolDownSeconds => _currentCoolDownSeconds;
}
