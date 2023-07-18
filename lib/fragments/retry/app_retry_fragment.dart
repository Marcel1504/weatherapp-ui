import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weatherapp_ui/fragments/button/app_rounded_icon_button.dart';
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
        AppRoundIconButtonComponent(
          size: 25,
          action: () => retryAction(),
          icon: Icons.refresh,
          primary: true,
        )
      ],
    );
  }
}
