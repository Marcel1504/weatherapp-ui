import 'package:weatherapp_ui/providers/export/app_export_provider.dart';
import 'package:weatherapp_ui/services/backend/data/export/app_export_data_backend_service.dart';
import 'package:weatherapp_ui/services/backend/data/export/app_soil_export_data_backend_service.dart';

class AppSoilExportProvider extends AppExportProvider {
  @override
  AppExportDataBackendService getBackendService() {
    return AppSoilExportDataBackendService();
  }
}
