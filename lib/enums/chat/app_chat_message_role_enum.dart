import 'package:json_annotation/json_annotation.dart';

enum AppChatMessageRoleEnum {
  @JsonValue("USER")
  user,
  @JsonValue("ASSISTANT")
  assistant,
  @JsonValue("FUNCTION")
  function,
  @JsonValue("SYSTEM")
  system
}
