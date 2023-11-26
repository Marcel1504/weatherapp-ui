import 'package:json_annotation/json_annotation.dart';
import 'package:weatherapp_ui/dto/response/chat/app_chat_message_response_dto.dart';

part 'app_chat_response_dto.g.dart';

@JsonSerializable()
class AppChatResponseDto {
  AppChatResponseDto({this.chatId, this.messages});

  int? chatId;
  List<AppChatMessageResponseDto>? messages;

  factory AppChatResponseDto.fromJson(Map<String, dynamic> json) => _$AppChatResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppChatResponseDtoToJson(this);
}
