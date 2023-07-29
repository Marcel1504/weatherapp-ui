import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppReviewDetailDataRainChartFragment extends StatefulWidget {
  final List<double> rain;
  final List<String> timeLabels;

  const AppReviewDetailDataRainChartFragment(
      {super.key, required this.rain, required this.timeLabels});

  @override
  State<AppReviewDetailDataRainChartFragment> createState() =>
      _AppReviewDetailDataRainChartFragmentState();
}

class _AppReviewDetailDataRainChartFragmentState
    extends State<AppReviewDetailDataRainChartFragment> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.timeLabels.isEmpty ||
        widget.rain.isEmpty ||
        widget.rain.every((r) => r == 0)) {
      return Container();
    }
    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: double.maxFinite,
          width: 50 * widget.timeLabels.length.toDouble(),
          child: _chartRoot(context),
        ),
      ),
    );
  }

  Widget _chartRoot(BuildContext context) {
    return BarChart(BarChartData(
        barTouchData: _barTouchData(context),
        titlesData: _titlesData(),
        borderData: _borderData(context),
        gridData: FlGridData(show: false),
        barGroups: _barChartGroupData(),
        minY: 0,
        maxY: _getMaxRain().toInt() + 10));
  }

  double _getMaxRain() {
    double? max;
    for (double r in widget.rain) {
      if (max == null || r > max) {
        max = r;
      }
    }
    return max ?? 100;
  }

  FlBorderData _borderData(BuildContext context) {
    BorderSide side = BorderSide(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7));
    return FlBorderData(border: Border(bottom: side, top: side));
  }

  FlTitlesData _titlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(sideTitles: _timeTitles()),
      leftTitles: AxisTitles(
        sideTitles: _rainTitles(),
      ),
      topTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (i, meta) => Container(),
      )),
      rightTitles: AxisTitles(
        sideTitles: _rainTitles(),
      ),
    );
  }

  SideTitles _rainTitles() {
    return SideTitles(
      getTitlesWidget: (i, meta) =>
          SideTitleWidget(axisSide: meta.axisSide, child: Text("$i l/m²")),
      reservedSize: 100,
      showTitles: true,
    );
  }

  SideTitles _timeTitles() {
    return SideTitles(
      showTitles: true,
      reservedSize: 60,
      getTitlesWidget: (i, meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          angle: 1,
          child: Text(widget.timeLabels[i.toInt() - 1])),
    );
  }

  BarTouchData _barTouchData(BuildContext context) {
    return BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: EdgeInsets.zero,
            tooltipMargin: 8,
            getTooltipItem: (g, i1, r, i2) =>
                _barTooltipItem(context, g, i1, r, i2)));
  }

  BarTooltipItem _barTooltipItem(
      BuildContext context,
      BarChartGroupData groupData,
      int index,
      BarChartRodData rodData,
      int index2) {
    return BarTooltipItem(
        rodData.toY.toString(), Theme.of(context).textTheme.headlineMedium!);
  }

  List<BarChartGroupData> _barChartGroupData() {
    return widget.timeLabels
        .mapIndexed((index, time) => BarChartGroupData(
            x: index + 1, barRods: [BarChartRodData(toY: widget.rain[index])]))
        .toList();
  }
}
