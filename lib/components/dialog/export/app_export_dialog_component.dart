import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/dialog/app_dialog_component.dart';
import 'package:weatherapp_ui/components/input/app_value_input_component.dart';
import 'package:weatherapp_ui/components/picker/app_picker_day_component.dart';
import 'package:weatherapp_ui/components/text/app_header_text_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/dto/request/data/export/app_export_data_request_dto.dart';
import 'package:weatherapp_ui/providers/export/app_export_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppExportDialogComponent extends StatefulWidget {
  final String title;
  final AppExportProvider provider;

  const AppExportDialogComponent({super.key, required this.title, required this.provider});

  @override
  State<AppExportDialogComponent> createState() => _AppExportDialogComponentState();
}

class _AppExportDialogComponentState extends State<AppExportDialogComponent> {
  String? _startDay;
  String? _endDay;
  String? _stationCode;
  String? _email;
  bool _emailValid = false;

  @override
  void initState() {
    super.initState();
    _stationCode = Provider.of<AppStationProvider>(context, listen: false).selectedStation?.code;
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogComponent(
      title: widget.title,
      onClose: () => {},
      onAccept: _allInputsFilled()
          ? () => widget.provider.exportDataForStationCode(
              startDay: _startDay,
              endDay: _endDay,
              stationCode: _stationCode,
              request: AppExportDataRequestDto(email: _email))
          : null,
      child: ListView(
        children: [
          AppHeaderTextComponent(title: AppL18nConfig.get(context).export_subtitle_range),
          AppPickerDayComponent(
            title: AppL18nConfig.get(context).export_value_from,
            onSelected: (d) => setState(() =>
                _startDay = AppTimeService().transformDateTime(context, d, pattern: AppTimeService.isoDayPattern)),
          ),
          const Divider(),
          AppPickerDayComponent(
            title: AppL18nConfig.get(context).export_value_to,
            onSelected: (d) => setState(
                () => _endDay = AppTimeService().transformDateTime(context, d, pattern: AppTimeService.isoDayPattern)),
          ),
          AppHeaderTextComponent(title: AppL18nConfig.get(context).export_subtitle_email),
          AppValueInputComponent(
            icon: Icons.email,
            type: ValueType.email,
            hint: AppL18nConfig.get(context).export_value_email,
            invalidHint: AppL18nConfig.get(context).export_value_email_invalid,
            onChanged: (v, b) => setState(() {
              _email = v;
              _emailValid = b;
            }),
          )
        ],
      ),
    );
  }

  bool _allInputsFilled() {
    return _emailValid && _stationCode != null && _startDay != null && _endDay != null;
  }
}
