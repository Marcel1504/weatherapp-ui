import 'package:flutter/cupertino.dart';
import 'package:weatherapp_ui/dto/response/app_list_response_dto.dart';
import 'package:weatherapp_ui/enums/app_calendar_enum.dart';
import 'package:weatherapp_ui/services/backend/summary/detail/app_detail_summary_backend_service.dart';

abstract class AppDetailSummaryProvider<LIST extends AppListResponseDto, DATA, SORT> extends ChangeNotifier {
  List<DATA> _data = [];
  bool _loading = false;
  AppCalendarEnum? _type;
  String? _stationCode;
  String? _time;

  void loadDetailsByStationCode(String? stationCode, String? time, AppCalendarEnum type) {
    _stationCode = stationCode;
    _time = time;
    _data = [];
    _type = type;
    _load();
  }

  @protected
  AppDetailDataBackendService<LIST> getBackendService();

  @protected
  List<DATA> getDataFromList(LIST? list);

  void _load({bool notifyLoadStart = false}) {
    if (!_loading) {
      _loading = true;
      if (notifyLoadStart) {
        notifyListeners();
      }
      Future<LIST?> future;
      switch (_type) {
        case AppCalendarEnum.DAY:
          future = getBackendService().getDayDetails(_stationCode, _time);
          break;
        case AppCalendarEnum.MONTH:
          future = getBackendService().getMonthsDetails(_stationCode, _time);
          break;
        case AppCalendarEnum.YEAR:
          future = getBackendService().getYearDetails(_stationCode, _time);
          break;
        default:
          future = Future.delayed(const Duration(seconds: 0));
      }
      future.then((list) {
        _data = getDataFromList(list);
        _loading = false;
        notifyListeners();
      }).catchError((_) {
        _loading = false;
        notifyListeners();
      });
    }
  }

  bool get loading => _loading;

  List<DATA> get data => _data;

  String? get time => _time;
}
