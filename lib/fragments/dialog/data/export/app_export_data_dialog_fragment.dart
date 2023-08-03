import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/dto/request/data/export/app_export_data_request_dto.dart';
import 'package:weatherapp_ui/fragments/dialog/app_dialog_fragment.dart';
import 'package:weatherapp_ui/fragments/form/app_form_field_fragment.dart';
import 'package:weatherapp_ui/fragments/picker/app_picker_day_fragment.dart';
import 'package:weatherapp_ui/fragments/text/app_header_text_fragment.dart';
import 'package:weatherapp_ui/providers/data/export/app_export_data_provider.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppExportDataDialogFragment extends StatefulWidget {
  final String title;
  final AppExportDataProvider provider;

  const AppExportDataDialogFragment(
      {super.key, required this.title, required this.provider});

  @override
  State<AppExportDataDialogFragment> createState() =>
      _AppExportDataDialogFragmentState();
}

class _AppExportDataDialogFragmentState
    extends State<AppExportDataDialogFragment> {
  String? _startDay;
  String? _endDay;
  String? _stationCode;
  String? _email;
  bool _emailValid = false;

  @override
  void initState() {
    super.initState();
    _stationCode = Provider.of<AppStationProvider>(context, listen: false)
        .selectedStation
        ?.code;
  }

  @override
  Widget build(BuildContext context) {
    return AppDialogFragment(
      title: widget.title,
      onAccept: _allInputsFilled()
          ? () => widget.provider.exportDataForStationCode(
              startDay: _startDay,
              endDay: _endDay,
              stationCode: _stationCode,
              request: AppExportDataRequestDto(email: _email))
          : null,
      child: ListView(
        children: [
          AppHeaderTextFragment(
              title: AppLocalizations.of(context)!.export_subtitle_range),
          AppPickerDayFragment(
            title: AppLocalizations.of(context)!.export_value_from,
            onSelected: (d) => setState(() => _startDay = AppTimeService()
                .transformDateTime(context, d,
                    pattern: AppTimeService.isoDayPattern)),
          ),
          const Divider(),
          AppPickerDayFragment(
            title: AppLocalizations.of(context)!.export_value_to,
            onSelected: (d) => setState(() => _endDay = AppTimeService()
                .transformDateTime(context, d,
                    pattern: AppTimeService.isoDayPattern)),
          ),
          AppHeaderTextFragment(
              title: AppLocalizations.of(context)!.export_subtitle_email),
          AppFormFieldFragment(
            icon: Icons.email,
            type: TextInputType.emailAddress,
            hint: AppLocalizations.of(context)!.export_value_email,
            invalidHint:
                AppLocalizations.of(context)!.export_value_email_invalid,
            onChanged: (v, b) => setState(() {
              _email = v;
              _emailValid = b;
            }),
            validation: (v) => _isValidEmail(v),
            filter: FilterType.NONE,
          )
        ],
      ),
    );
  }

  bool _isValidEmail(String? email) {
    return email != null &&
        email.isNotEmpty &&
        RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
  }

  bool _allInputsFilled() {
    return _emailValid &&
        _stationCode != null &&
        _startDay != null &&
        _endDay != null;
  }
}
