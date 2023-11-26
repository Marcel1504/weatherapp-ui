import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_icon_button_component.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppDialogFragment extends StatelessWidget {
  final String? title;
  final bool titlePrimary;
  final Widget child;
  final double? height;
  final double? width;
  final Function()? onAccept;
  final Function()? onClose;

  const AppDialogFragment(
      {super.key,
      required this.child,
      this.onAccept,
      this.title,
      this.height = double.maxFinite,
      this.width = double.maxFinite,
      this.onClose,
      this.titlePrimary = false});

  @override
  Widget build(BuildContext context) {
    Color titleColor = titlePrimary ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface;
    return AlertDialog(
      title: Text(title ?? "",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: titleColor, fontSize: AppLayoutConfig.dialogTitleFontSize)),
      content: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppLayoutService().maxWidth()),
          child: SizedBox(height: height, width: width, child: child)),
      actions: _buttons(context),
    );
  }

  List<Widget> _buttons(BuildContext context) {
    return [
      onClose != null
          ? AppIconButtonComponent(
              type: AppButtonTypeEnum.secondary,
              icon: Icons.close,
              onTap: () {
                onClose?.call();
                Navigator.of(context).pop();
              },
            )
          : Container(),
      onAccept != null
          ? AppIconButtonComponent(
              type: AppButtonTypeEnum.primary,
              icon: Icons.check,
              onTap: () {
                onAccept?.call();
                Navigator.of(context).pop();
              },
            )
          : Container()
    ];
  }
}
