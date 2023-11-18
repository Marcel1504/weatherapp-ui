import 'package:flutter/cupertino.dart';
import 'package:weatherapp_ui/dto/response/app_list_response_dto.dart';
import 'package:weatherapp_ui/services/api/data/summary/app_summary_data_api_service.dart';

abstract class AppSummaryDataProvider<LIST extends AppListResponseDto, DATA, FILTER> extends ChangeNotifier {
  List<DATA> _data = [];
  bool _loading = false;
  bool _reset = true;
  bool _resetFilter = true;
  int _page = 0;
  bool _hasNext = true;
  String? _stationCode;
  FILTER? _filter;

  void loadNext({bool notifyLoadStart = false}) {
    _load(notifyLoadStart: notifyLoadStart);
  }

  void loadInitialByStationCode(String? stationCode, {bool notifyLoadStart = false}) {
    if (_reset || (stationCode != _stationCode)) {
      if (_resetFilter || (stationCode != _stationCode)) {
        _filter = null;
      }
      _data = [];
      _page = 0;
      _hasNext = true;
      _stationCode = stationCode;
      _load(notifyLoadStart: notifyLoadStart);
    }
  }

  void setFilter({required FILTER filter}) {
    _filter = filter;
    markForReset(resetFilter: false);
  }

  void markForReset({bool resetFilter = true}) {
    if (resetFilter) {
      _resetFilter = true;
    }
    _reset = true;
  }

  @protected
  AppSummaryDataApiService<LIST, FILTER> getApiService();

  @protected
  List<DATA> getDataFromList(LIST? list);

  void _load({bool notifyLoadStart = false}) {
    if (!_loading && _stationCode != null && _hasNext) {
      _loading = true;
      if (notifyLoadStart) {
        notifyListeners();
      }
      getApiService().getNext(_stationCode, _page, _filter).then((list) {
        _data.addAll(getDataFromList(list));
        _hasNext = list?.hasNext ?? false;
        _loading = false;
        _reset = false;
        _resetFilter = false;
        _page++;
        notifyListeners();
      }).catchError((_) {
        _loading = false;
        notifyListeners();
      });
    }
  }

  bool get loading => _loading;

  FILTER? get filter => _filter;

  List<DATA> get data => _data;
}
