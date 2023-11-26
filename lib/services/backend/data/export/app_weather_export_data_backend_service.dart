import 'package:weatherapp_ui/services/backend/data/export/app_export_data_backend_service.dart';

class AppWeatherExportDataBackendService extends AppExportDataBackendService {
  @override
  String getExportEndpoint() {
    return "/weather/export";
  }
}
