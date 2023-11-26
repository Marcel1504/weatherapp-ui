import 'package:weatherapp_ui/enums/chat/app_chat_message_role_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_type_enum.dart';

class AppChatMessageModel {
  AppChatMessageModel({this.content, required this.role, required this.type});

  String? content;
  AppChatMessageRoleEnum role;
  AppChatMessageTypeEnum type;
}
