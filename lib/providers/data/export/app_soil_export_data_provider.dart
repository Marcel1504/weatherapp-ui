import 'package:weatherapp_ui/providers/data/export/app_export_data_provider.dart';
import 'package:weatherapp_ui/services/api/data/export/app_export_data_api_service.dart';
import 'package:weatherapp_ui/services/api/data/export/app_soil_export_data_api_service.dart';

class AppSoilExportDataProvider extends AppExportDataProvider {
  @override
  AppExportDataApiService getApiService() {
    return AppSoilExportDataApiService();
  }
}
