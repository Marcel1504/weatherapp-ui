import 'package:weatherapp_ui/providers/export/app_export_provider.dart';
import 'package:weatherapp_ui/services/backend/export/app_export_backend_service.dart';
import 'package:weatherapp_ui/services/backend/export/app_weather_export_backend_service.dart';

class AppWeatherExportProvider extends AppExportProvider {
  @override
  AppExportBackendService getBackendService() {
    return AppWeatherExportBackendService();
  }
}
