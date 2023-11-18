import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/fragments/button/app_round_icon_button.dart';
import 'package:weatherapp_ui/models/app_file_model.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/datepicker/app_datepicker_service.dart';
import 'package:weatherapp_ui/services/layout/app_layout_service.dart';
import 'package:weatherapp_ui/services/time/app_time_service.dart';

class AppStationMediaFragment extends StatefulWidget {
  const AppStationMediaFragment({super.key});

  @override
  State<AppStationMediaFragment> createState() => _AppStationMediaFragmentState();
}

class _AppStationMediaFragmentState extends State<AppStationMediaFragment> {
  bool _showLatest = true;
  DateTime? _selectedReviewDate;
  AppFileModel? _image;

  Map<IconData, Function()> _quickActions = {};

  @override
  Widget build(BuildContext context) {
    _image = null;
    double width = MediaQuery.of(context).size.width;
    return Consumer<AppStationProvider>(builder: (context, provider, widget) {
      _image = _showLatest ? provider.selectedStationMediaFileLatest : provider.selectedStationMediaFileReview;
      _setQuickActions();
      return Stack(
        children: [
          Positioned(child: _imageDisplay(provider)),
          Positioned(
            top: AppLayoutService().betweenItemPadding(),
            width: width,
            child: _headerDisplay(provider),
          ),
          Positioned(bottom: 0, width: width, child: _quickActionsDisplay()),
        ],
      );
    });
  }

  Widget _imageDisplay(AppStationProvider provider) {
    Uint8List? data = _image?.data;
    return data != null
        ? PhotoViewGallery.builder(
        itemCount: 1,
            builder: (context, index) => PhotoViewGalleryPageOptions(
                imageProvider: MemoryImage(data),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2),
            backgroundDecoration: const BoxDecoration(color: Colors.transparent),
            enableRotation: false)
        : Container();
  }

  Widget _headerDisplay(AppStationProvider provider) {
    String? text;
    AppTimeService timeService = AppTimeService();
    if (_showLatest) {
      if (_image == null) {
        text = AppLocalizations.of(context)!.station_media_no_data_latest;
      } else {
        text = AppLocalizations.of(context)!.station_media_created_latest(
            timeService.transformISOTimeStringToCurrentDuration(
                    context, provider.selectedStation?.latestStationMedia?.created) ??
                "?");
      }
    } else {
      String? date = timeService.transformDateTime(context, _selectedReviewDate, pattern: "dd. MMMM yyyy");
      if (_image == null) {
        text = AppLocalizations.of(context)!.station_media_no_data_review(date ?? "?");
      } else {
        text = date;
      }
    }
    return Text(
      text ?? "",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _quickActionsDisplay() {
    AppLayoutService layoutService = AppLayoutService();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _quickActions.entries
          .map((v) => Padding(
                padding: EdgeInsets.only(
                    bottom: layoutService.betweenItemPadding() * 2,
                    right: layoutService.betweenItemPadding(),
                    left: layoutService.betweenItemPadding()),
                child: AppRoundIconButtonComponent(
                  icon: v.key,
                  primary: false,
                  action: () => v.value.call(),
                ),
              ))
          .toList(),
    );
  }

  void _setQuickActions() {
    _quickActions = {};
    _quickActions.putIfAbsent(Icons.calendar_month, () => () => _openDatePicker());
    if (_image != null) {
      _quickActions.putIfAbsent(Icons.open_in_new, () => () => _openImage());
    }
    if (!_showLatest) {
      _quickActions.putIfAbsent(Icons.fast_forward, () => () => setState(() => _showLatest = true));
    }
  }

  void _openDatePicker() {
    AppDatePickerService()
        .showAppDatePicker(context, initial: _selectedReviewDate ?? DateTime.now())
        .then((date) => setState(() {
              if (date != null) {
                _selectedReviewDate = date;
                _showLatest = false;
                Provider.of<AppStationProvider>(context, listen: false).loadStationMediaReview(AppTimeService()
                    .transformDateTime(context, _selectedReviewDate, pattern: AppTimeService.isoDayPattern));
              }
            }));
  }

  void _openImage() {
    if (_image != null) {
      AnchorElement anchorElement = AnchorElement(href: _image?.url);
      anchorElement.target = "blank";
      anchorElement.click();
    }
  }
}
