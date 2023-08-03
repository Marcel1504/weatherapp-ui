import 'package:weatherapp_ui/services/api/data/export/app_export_data_api_service.dart';

class AppWeatherExportDataApiService extends AppExportDataApiService {
  @override
  String getExportEndpoint() {
    return "/weather/export";
  }
}
