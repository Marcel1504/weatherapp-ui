import 'package:weatherapp_ui/services/backend/export/app_export_backend_service.dart';

class AppSoilExportBackendService extends AppExportBackendService {
  @override
  String getExportEndpoint() {
    return "/soil/export";
  }
}
