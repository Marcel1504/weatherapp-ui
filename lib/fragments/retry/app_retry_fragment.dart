import 'package:flutter/material.dart';
import 'package:weatherapp_ui/components/button/app_icon_button_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';

class AppRetryFragment extends StatelessWidget {
  final Function retryAction;

  const AppRetryFragment({super.key, required this.retryAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: AppLayoutConfig.defaultSpacing,
              right: AppLayoutConfig.defaultSpacing,
              bottom: AppLayoutConfig.defaultSpacing),
          child: Text(
            AppL18nConfig.get(context).error_noConnection,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
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
