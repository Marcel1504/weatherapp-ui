import 'package:flutter/material.dart';
import 'package:weatherapp_ui/fragments/button/app_round_icon_button.dart';
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
    Color titleColor =
        titlePrimary ? Theme.of(context).colorScheme.primary : Theme.of(context).textTheme.bodyMedium!.color!;
    return AlertDialog(
      title: Text(title ?? "", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: titleColor)),
      content: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppLayoutService().maxWidth()),
          child: SizedBox(height: height, width: width, child: child)),
      actions: _buttons(context),
    );
  }

  List<Widget> _buttons(BuildContext context) {
    return [
      onClose != null
          ? AppRoundIconButtonComponent(
              primary: false,
              icon: Icons.close,
              action: () {
                onClose?.call();
                Navigator.of(context).pop();
              },
            )
          : Container(),
      onAccept != null
          ? AppRoundIconButtonComponent(
              icon: Icons.check,
              action: () {
                onAccept?.call();
                Navigator.of(context).pop();
              },
            )
          : Container()
    ];
  }
}
