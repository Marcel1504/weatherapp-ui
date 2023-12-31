import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_ui/components/button/app_icon_button_component.dart';
import 'package:weatherapp_ui/config/app_l18n_config.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';
import 'package:weatherapp_ui/enums/app_button_type_enum.dart';
import 'package:weatherapp_ui/models/app_file_model.dart';
import 'package:weatherapp_ui/providers/station/app_station_provider.dart';
import 'package:weatherapp_ui/services/datepicker/app_datepicker_service.dart';
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
            top: AppLayoutConfig.defaultSpacing,
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
        text = AppL18nConfig.get(context).station_media_no_data_latest;
      } else {
        text = AppL18nConfig.get(context).station_media_created_latest(
            timeService.transformISOTimeStringToCurrentDuration(
                    context, provider.selectedStation?.latestStationMedia?.created) ??
                "?");
      }
    } else {
      String? date = timeService.transformDateTime(context, _selectedReviewDate, pattern: "dd. MMMM yyyy");
      if (_image == null) {
        text = AppL18nConfig.get(context).station_media_no_data_review(date ?? "?");
      } else {
        text = date;
      }
    }
    return Text(
      text ?? "",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextBodyFontSize),
    );
  }

  Widget _quickActionsDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _quickActions.entries
          .map((v) => Padding(
                padding: const EdgeInsets.only(
                    bottom: AppLayoutConfig.defaultSpacing * 2,
                    right: AppLayoutConfig.defaultSpacing,
                    left: AppLayoutConfig.defaultSpacing),
                child: AppIconButtonComponent(
                  icon: v.key,
                  type: AppButtonTypeEnum.secondary,
                  onTap: () => v.value.call(),
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
