import 'package:flutter/material.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppIconTextFragment extends StatelessWidget {
  final String? text;
  final IconData icon;
  final double? size;
  final Color? color;

  const AppIconTextFragment(
      {super.key,
      this.text,
      this.icon = Icons.question_mark,
      this.size,
      this.color});

  @override
  Widget build(BuildContext context) {
    AppLayoutService layoutService = AppLayoutService();
    return text != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color?.withOpacity(0.7),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: layoutService.betweenItemPadding()),
                child: Text(
                  text!,
                  style: TextStyle(color: color, fontSize: size),
                ),
              )
            ],
          )
        : Container();
  }
}
