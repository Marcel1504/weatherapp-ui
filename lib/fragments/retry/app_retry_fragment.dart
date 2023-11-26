import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weatherapp_ui/components/button/app_icon_button_component.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';

class AppRetryFragment extends StatelessWidget {
  final Function retryAction;

  const AppRetryFragment({super.key, required this.retryAction});

  @override
  Widget build(BuildContext context) {
    AppLayoutService layoutService = AppLayoutService();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: layoutService.betweenItemPadding() * 2,
              right: layoutService.betweenItemPadding() * 2,
              bottom: layoutService.betweenItemPadding() * 2),
          child: Text(
            AppLocalizations.of(context)!.error_noConnection,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        AppIconButtonComponent(
          onTap: () => retryAction(),
          icon: Icons.refresh,
          type: AppButtonTypeEnum.primary,
        )
      ],
    );
  }
}
