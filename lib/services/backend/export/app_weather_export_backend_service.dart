import 'package:weatherapp_ui/services/backend/export/app_export_backend_service.dart';

class AppWeatherExportBackendService extends AppExportBackendService {
  @override
  String getExportEndpoint() {
    return "/weather/export";
  }
}
