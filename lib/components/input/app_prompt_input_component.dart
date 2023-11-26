import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_icon_button_component.dart';
import 'package:weatherapp_ui/components/input/app_input_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';

class AppPromptInputComponent extends StatefulWidget {
  final String? hint;
  final bool disabled;
  final Function(String)? onTextSent;
  final double size;

  const AppPromptInputComponent(
      {super.key, this.hint, this.onTextSent, this.size = AppLayoutConfig.inputDefaultSize, this.disabled = false});

  @override
  State<AppPromptInputComponent> createState() => _AppPromptInputComponentState();
}

class _AppPromptInputComponentState extends State<AppPromptInputComponent> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _getTextField(context)),
        Padding(
          padding: EdgeInsets.only(left: widget.size / 4),
          child: _getSendButton(context),
        )
      ],
    );
  }

  Widget _getTextField(BuildContext context) {
    return AppInputComponent(
      size: widget.size,
      hint: widget.hint,
      inputType: TextInputType.multiline,
      controller: _controller,
      onInputChanged: (t) => setState(() {}),
    );
  }

  Widget _getSendButton(BuildContext context) {
    return AppIconButtonComponent(
      icon: Icons.send,
      size: widget.size * 0.9,
      onTap: !widget.disabled && _controller.text.isNotEmpty ? () => _onTextSent(context) : null,
      type: AppButtonTypeEnum.primary,
    );
  }

  void _onTextSent(BuildContext context) {
    widget.onTextSent?.call(_controller.text);
    setState(() => _controller.text = "");
  }
}
