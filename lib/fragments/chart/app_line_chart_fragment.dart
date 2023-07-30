import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_ui/fragments/chip/app_choice_chip_list_fragment.dart';

class AppLineChartFragment extends StatefulWidget {
  final List<List<double?>> valueLists;
  final List<String> valueTitles;
  final List<String> labels;
  final String? noDataText;
  final String? valueUnit;
  final LinearGradient Function(BuildContext, List<double?>) lineGradient;

  const AppLineChartFragment(
      {super.key,
      required this.valueLists,
      required this.valueTitles,
      required this.labels,
      this.noDataText,
      required this.lineGradient,
      this.valueUnit});

  @override
  State<AppLineChartFragment> createState() => _AppLineChartFragmentState();
}

class _AppLineChartFragmentState extends State<AppLineChartFragment> {
  late ScrollController _scrollController;
  int _selectedChartIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.labels.isEmpty ||
        widget.valueLists.any((list) => list.none((v) => v != null)) ||
        widget.valueTitles.isEmpty) {
      return Center(
        child: Text(widget.noDataText ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center),
      );
    }
    return Column(
      children: [
        AppChoiceChipListFragment(
            primary: false,
            onTap: (i) => setState(() => _selectedChartIndex = i),
            titles: widget.valueTitles),
        Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            controller: _scrollController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: SizedBox(
                height: double.maxFinite,
                width: 50 * widget.labels.length.toDouble(),
                child: _chartRoot(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _chartRoot(BuildContext context) {
    double minValue = _minValue().toDouble();
    double maxValue = _maxValue().toDouble();
    double maxY = maxValue.ceilToDouble();
    double minY = minValue.floorToDouble();

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
        borderData: _borderData(context),
        titlesData: _titlesData(context),
        lineBarsData: _lineBarsData(context),
        minX: 1,
        maxX: widget.labels.length.toDouble(),
        minY: minY,
        maxY: maxY));
  }

  double _minValue() {
    double? min;
    for (List<double?> list in widget.valueLists) {
      for (double? t in list) {
        if (min == null || (t != null && t < min)) {
          min = t;
        }
      }
    }
    return min ?? -30;
  }

  double _maxValue() {
    double? max;
    for (List<double?> list in widget.valueLists) {
      for (double? t in list) {
        if (max == null || (t != null && t > max)) {
          max = t;
        }
      }
    }
    return max ?? 40;
  }

  FlBorderData _borderData(BuildContext context) {
    BorderSide side = BorderSide(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7));
    return FlBorderData(border: Border(bottom: side, top: side));
  }

  LineTouchData _lineTouchData(BuildContext context) {
    return LineTouchData(
      handleBuiltInTouches: true,
      getTouchedSpotIndicator: (_, list) =>
          _touchedSpotIndicatorDataList(context, list),
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
        .mapIndexed((index, s) => LineTooltipItem("${s.y} ${widget.valueUnit}",
            Theme.of(context).textTheme.headlineMedium!))
        .toList();
  }

  List<TouchedSpotIndicatorData> _touchedSpotIndicatorDataList(
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
        reservedSize: 10,
        getTitlesWidget: (i, meta) => Container(),
      )),
      leftTitles: AxisTitles(
        sideTitles: _temperatureTitles(context),
      ),
    );
  }

  SideTitles _temperatureTitles(BuildContext context) {
    return SideTitles(
      getTitlesWidget: (i, meta) => SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          i.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
      reservedSize: 60,
      showTitles: true,
    );
  }

  SideTitles _timeTitles(BuildContext context) {
    return SideTitles(
      showTitles: true,
      reservedSize: 60,
      interval: 1,
      getTitlesWidget: (i, meta) => SideTitleWidget(
        axisSide: meta.axisSide,
        angle: 1,
        child: Text(
          widget.labels[i.toInt() - 1],
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }

  List<LineChartBarData> _lineBarsData(BuildContext context) {
    List<double?> list = widget.valueLists[_selectedChartIndex];
    return [
      LineChartBarData(
        isCurved: true,
        preventCurveOverShooting: true,
        barWidth: 4,
        gradient: widget.lineGradient.call(context, list),
        isStrokeCapRound: false,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: list
            .where((t) => t != null)
            .mapIndexed((index, t) => FlSpot(index.toDouble() + 1, t!))
            .toList(),
      )
    ];
  }
}
