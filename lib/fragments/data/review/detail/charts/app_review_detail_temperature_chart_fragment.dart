import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_ui/services/color/app_color_service.dart';

class AppReviewDetailTemperatureChartFragment extends StatefulWidget {
  final List<List<double?>> temperatureLists;
  final List<String> temperatureListTitles;
  final List<String> timeLabels;

  const AppReviewDetailTemperatureChartFragment(
      {super.key,
      required this.temperatureLists,
      required this.temperatureListTitles,
      required this.timeLabels});

  @override
  State<AppReviewDetailTemperatureChartFragment> createState() =>
      _AppReviewDetailTemperatureChartFragmentState();
}

class _AppReviewDetailTemperatureChartFragmentState
    extends State<AppReviewDetailTemperatureChartFragment> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.timeLabels.isEmpty ||
        widget.temperatureLists.any((list) => list.isEmpty) ||
        widget.temperatureListTitles.isEmpty) {
      return Container();
    }
    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: SizedBox(
          height: double.maxFinite,
          width: 50 * widget.timeLabels.length.toDouble(),
          child: _chartRoot(context),
        ),
      ),
    );
  }

  Widget _chartRoot(BuildContext context) {
    double maxTemp = _getMaxTemperature().toDouble();
    double minTemp = _getMinTemperature().toDouble();
    double maxY = (maxTemp.ceil() + 1);
    double minY = (minTemp.floor() - 1);

    return LineChart(LineChartData(
        lineTouchData: _lineTouchData(context),
        gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (i) => FlLine(
                strokeWidth: 1,
                dashArray: [4],
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.4))),
        borderData: _getBorderData(context),
        titlesData: _titlesData(context),
        lineBarsData: _lineBarsData(context),
        minX: 1,
        maxX: widget.timeLabels.length.toDouble(),
        minY: minY,
        maxY: maxY));
  }

  double _getMinTemperature() {
    double? min;
    for (List<double?> list in widget.temperatureLists) {
      for (double? t in list) {
        if (min == null || (t != null && t < min)) {
          min = t;
        }
      }
    }
    return min ?? -30;
  }

  double _getMaxTemperature() {
    double? max;
    for (List<double?> list in widget.temperatureLists) {
      for (double? t in list) {
        if (max == null || (t != null && t > max)) {
          max = t;
        }
      }
    }
    return max ?? 40;
  }

  FlBorderData _getBorderData(BuildContext context) {
    BorderSide side = BorderSide(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7));
    return FlBorderData(border: Border(bottom: side, top: side));
  }

  LineTouchData _lineTouchData(BuildContext context) {
    return LineTouchData(
      handleBuiltInTouches: true,
      getTouchedSpotIndicator: (_, list) =>
          _getTouchedSpotIndicatorDataList(context, list),
      touchTooltipData: LineTouchTooltipData(
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          tooltipBgColor: Theme.of(context).colorScheme.surface,
          getTooltipItems: (spots) => _toolTipItems(context, spots)),
    );
  }

  List<LineTooltipItem> _toolTipItems(
      BuildContext context, List<LineBarSpot> spots) {
    return spots
        .mapIndexed((index, s) => LineTooltipItem(
            "${s.y} °C (${widget.temperatureListTitles[index]})",
            Theme.of(context).textTheme.headlineMedium!))
        .toList();
  }

  List<TouchedSpotIndicatorData> _getTouchedSpotIndicatorDataList(
      BuildContext context, List<int> list) {
    return list
        .map((e) => TouchedSpotIndicatorData(
            FlLine(
                dashArray: [4],
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                strokeWidth: 1),
            FlDotData(
                show: true,
                getDotPainter: (a, b, c, d) => FlDotCrossPainter(
                    color: Theme.of(context).colorScheme.onBackground))))
        .toList();
  }

  FlTitlesData _titlesData(BuildContext context) {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: _timeTitles(context),
      ),
      rightTitles: AxisTitles(
        sideTitles: _temperatureTitles(context),
      ),
      topTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (i, meta) => Container(),
      )),
      leftTitles: AxisTitles(
        sideTitles: _temperatureTitles(context),
      ),
    );
  }

  SideTitles _temperatureTitles(BuildContext context) {
    return SideTitles(
      getTitlesWidget: (i, meta) => _sideTitleWidget(context, i, meta),
      reservedSize: 60,
      showTitles: true,
    );
  }

  SideTitles _timeTitles(BuildContext context) {
    return SideTitles(
      showTitles: true,
      reservedSize: 60,
      getTitlesWidget: (i, meta) => _bottomTitleWidget(context, i, meta),
    );
  }

  Widget _bottomTitleWidget(BuildContext context, double i, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: 1,
      child: Text(
        widget.timeLabels[i.toInt() - 1],
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  Widget _sideTitleWidget(BuildContext context, double i, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        "$i °C",
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }

  List<LineChartBarData> _lineBarsData(BuildContext context) {
    AppColorService colorService = AppColorService();
    return widget.temperatureLists
        .map((list) => LineChartBarData(
              isCurved: true,
              preventCurveOverShooting: true,
              color: Colors.blue,
              barWidth: 2,
              gradient: colorService.getTemperatureColoredLineGradient(
                  context, list, 10),
              isStrokeCapRound: false,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              spots: list
                  .where((t) => t != null)
                  .mapIndexed((index, t) => FlSpot(index.toDouble() + 1, t!))
                  .toList(),
            ))
        .toList();
  }
}
