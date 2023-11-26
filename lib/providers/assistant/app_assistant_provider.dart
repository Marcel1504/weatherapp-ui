import 'package:flutter/cupertino.dart';
import 'package:weatherapp_ui/dto/request/chat/app_chat_request_dto.dart';
import 'package:weatherapp_ui/dto/response/chat/app_chat_response_dto.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_role_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_type_enum.dart';
import 'package:weatherapp_ui/models/app_chat_message_model.dart';
import 'package:weatherapp_ui/services/backend/assistant/app_assistant_backend_service.dart';

class AppAssistantProvider extends ChangeNotifier {
  final AppAssistantBackendService _backendService = AppAssistantBackendService();
  final List<AppChatMessageModel> _chatMessages = [];
  int? _chatId;
  bool _isLoading = false;
  bool _hasError = false;

  Future<void> sendChatMessage(String? message) async {
    if (message != null && !_isLoading) {
      _isLoading = true;
      notifyListeners();

      // add new message to chatMessage and also the loading indicator message
      _chatMessages.add(
          AppChatMessageModel(role: AppChatMessageRoleEnum.user, type: AppChatMessageTypeEnum.text, content: message));
      _chatMessages
          .add(AppChatMessageModel(role: AppChatMessageRoleEnum.assistant, type: AppChatMessageTypeEnum.loading));

      // perform request with the chat message
      AppChatRequestDto chatRequest = AppChatRequestDto(message: message, chatId: _chatId, contextStationId: 1);
      AppChatResponseDto? chatResponse = await _backendService.sendChatMessage(chatRequest);

      // remove loading message once the chat request is finished
      _chatMessages.removeWhere((m) => m.type == AppChatMessageTypeEnum.loading);

      // handle the chat response
      chatResponse != null ? _handleChatResponse(chatResponse) : _handleErrorResponse();
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearChat() {
    _chatMessages.clear();
    _chatId = null;
    _hasError = false;
    _isLoading = false;
    notifyListeners();
  }

  void _handleChatResponse(AppChatResponseDto response) {
    _chatId = response.chatId;
    response.messages?.map((m) {
      AppChatMessageRoleEnum? role = m.role;
      AppChatMessageTypeEnum type = m.type ?? AppChatMessageTypeEnum.text;
      if (role != null) {
        _chatMessages.add(AppChatMessageModel(role: role, type: type, content: m.content));
      }
    });
  }

  void _handleErrorResponse() {
    _hasError = true;
    _chatMessages.add(AppChatMessageModel(role: AppChatMessageRoleEnum.assistant, type: AppChatMessageTypeEnum.error));
  }

  List<AppChatMessageModel> get chatMessages => _chatMessages;

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;
}
