import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_role_enum.dart';
import 'package:weatherapp_ui/enums/chat/app_chat_message_type_enum.dart';

part 'app_chat_message_response_dto.g.dart';

@JsonSerializable()
class AppChatMessageResponseDto {
  AppChatMessageResponseDto({this.content, this.role, this.type, this.timestamp});

  String? content;
  AppChatMessageRoleEnum? role;
  AppChatMessageTypeEnum? type;
  String? timestamp;

  factory AppChatMessageResponseDto.fromJson(Map<String, dynamic> json) => _$AppChatMessageResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppChatMessageResponseDtoToJson(this);
}
