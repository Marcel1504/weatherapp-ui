import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weatherapp_ui/pages/app_root_page.dart';
import 'package:weatherapp_ui/providers/app_providers.dart' as app_providers;
import 'package:weatherapp_ui/themes/app_theme_dark.dart';
import 'package:weatherapp_ui/themes/app_theme_light.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: app_providers.get(),
      child: MaterialApp(
        title: 'Wetter-App',
        theme: AppThemeLight().get(),
        darkTheme: AppThemeDark().get(),
        themeMode: ThemeMode.system,
        home: const AppRootPage(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('de')],
      ),
    );
  }
}
