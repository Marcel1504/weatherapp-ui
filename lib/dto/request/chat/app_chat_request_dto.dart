import 'package:json_annotation/json_annotation.dart';

part 'app_chat_request_dto.g.dart';

@JsonSerializable()
class AppChatRequestDto {
  AppChatRequestDto({this.chatId, this.message, this.contextStationId});

  int? chatId;
  String? message;
  int? contextStationId;

  factory AppChatRequestDto.fromJson(Map<String, dynamic> json) => _$AppChatRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AppChatRequestDtoToJson(this);
}
