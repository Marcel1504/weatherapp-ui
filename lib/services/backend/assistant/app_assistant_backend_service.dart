import 'dart:convert';

import 'package:http/http.dart';
import 'package:weatherapp_ui/dto/request/chat/app_chat_request_dto.dart';
import 'package:weatherapp_ui/dto/response/chat/app_chat_response_dto.dart';
import 'package:weatherapp_ui/services/backend/app_backend_service.dart';

class AppAssistantBackendService extends AppBackendService {
  Future<AppChatResponseDto?> sendChatMessage(AppChatRequestDto message) async {
    try {
      Response res = await post(assistantUrl("/chat"),
          headers: {"Content-Type": "application/json"}, body: jsonEncode(message.toJson()));
      return res.statusCode == 200 ? AppChatResponseDto.fromJson(jsonDecode(res.body)) : null;
    } catch (exception) {
      return null;
    }
  }
}
