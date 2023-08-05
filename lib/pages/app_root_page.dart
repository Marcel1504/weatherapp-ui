import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/fragments/loading/app_loading_fragment.dart';
import 'package:weatherapp_ui/fragments/retry/app_retry_fragment.dart';
import 'package:weatherapp_ui/fragments/scaffold/app_scaffold_fragment.dart';
import 'package:weatherapp_ui/pages/home/app_home_page.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';

class AppRootPage extends StatelessWidget {
  const AppRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AppStationProvider>(context, listen: false).load();
    return AppScaffoldFragment(
      body: Center(
        child: Consumer<AppStationProvider>(
          builder: (context, provider, widget) {
            if (!provider.isLoading && provider.hasLoadingError) {
              return _initializationError(context);
            }
            if (provider.isLoading) {
              return _loading();
            }
            Future.delayed(Duration.zero, () => _openHomePage(context));
            return const Scaffold();
          },
        ),
      ),
    );
  }

  Widget _loading() {
    return const AppLoadingFragment(
      size: 50,
    );
  }

  Widget _initializationError(BuildContext context) {
    return AppRetryFragment(
        retryAction: () =>
            Provider.of<AppStationProvider>(context, listen: false)
                .load(notifyLoadStart: true));
  }

  void _openHomePage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const AppHomePage(),
        ));
  }
}
