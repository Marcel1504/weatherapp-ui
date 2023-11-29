import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:weatherapp_ui/dto/request/chat/app_chat_request_dto.dart';
import 'package:weatherapp_ui/dto/response/chat/app_chat_response_dto.dart';
import 'package:weatherapp_ui/dto/response/chat/message/app_chat_message_response_dto.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_error_code_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_role_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_type_enum.dart';
import 'package:weatherapp_ui/services/backend/app_backend_service.dart';

class AppAssistantBackendService extends AppBackendService {
  Future<AppChatResponseDto> sendChatMessage(AppChatRequestDto message) async {
    try {
      Response res = await post(assistantUrl("/chat"),
          headers: {"Content-Type": "application/json"}, body: jsonEncode(message.toJson()));
      switch (res.statusCode) {
        case 200:
          return AppChatResponseDto.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
      }
    } catch (exception) {
      log("Error while sending chat message: $exception");
    }
    return _getErrorResponse(AppChatErrorCodeEnum.assistant00003);
  }

  AppChatResponseDto _getErrorResponse(AppChatErrorCodeEnum error) {
    return AppChatResponseDto(chatId: null, messages: [
      AppChatMessageResponseDto(
          content: error.name, role: AppChatMessageRoleEnum.assistant, type: AppChatMessageTypeEnum.error)
    ]);
  }
}
