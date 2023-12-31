import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_ui/config/app_layout_config.dart';

class AppBarChartComponent extends StatefulWidget {
  final List<double?> values;
  final List<String> labels;
  final String? valueUnit;
  final String? noDataText;
  final LinearGradient Function(BuildContext, double, double) barGradient;

  const AppBarChartComponent(
      {super.key,
      required this.values,
      required this.labels,
      this.valueUnit,
      required this.barGradient,
      this.noDataText});

  @override
  State<AppBarChartComponent> createState() => _AppBarChartComponentState();
}

class _AppBarChartComponentState extends State<AppBarChartComponent> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.labels.isEmpty || widget.values.isEmpty || widget.values.every((r) => r == null || r == 0)) {
      return Center(
        child: Text(widget.noDataText ?? "",
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextHeadlineFontSize),
            textAlign: TextAlign.center),
      );
    }
    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: double.maxFinite,
          width: 50 * widget.labels.length.toDouble(),
          child: _chartRoot(),
        ),
      ),
    );
  }

  Widget _chartRoot() {
    return BarChart(BarChartData(
        barTouchData: _barTouchData(),
        titlesData: _titlesData(),
        borderData: _borderData(),
        gridData: FlGridData(show: false),
        barGroups: _barChartGroupData(),
        minY: 0,
        maxY: _maxValue() * 1.2));
  }

  double _maxValue() {
    double? max;
    for (double? v in widget.values) {
      if (max == null || (v != null && v > max)) {
        max = v;
      }
    }
    return max ?? 100;
  }

  FlBorderData _borderData() {
    return FlBorderData(
        border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7))));
  }

  FlTitlesData _titlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(sideTitles: _timeTitles()),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          getTitlesWidget: (i, meta) => Container(),
          reservedSize: 20,
          showTitles: true,
        ),
      ),
      topTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: false,
      )),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          getTitlesWidget: (i, meta) => Container(),
          reservedSize: 20,
          showTitles: true,
        ),
      ),
    );
  }

  SideTitles _timeTitles() {
    return SideTitles(
      showTitles: true,
      reservedSize: 60,
      getTitlesWidget: (i, meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          angle: 1,
          child: Text(
            widget.labels[i.toInt() - 1],
            style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextBodyFontSize),
          )),
    );
  }

  BarTouchData _barTouchData() {
    return BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            tooltipBgColor: Colors.transparent,
            tooltipPadding: EdgeInsets.zero,
            tooltipMargin: 8,
            getTooltipItem: (g, i1, r, i2) => _barTooltipItem(context, g, i1, r, i2)));
  }

  BarTooltipItem _barTooltipItem(
      BuildContext context, BarChartGroupData groupData, int index, BarChartRodData rodData, int index2) {
    return BarTooltipItem(rodData.toY != 0 ? "${rodData.toY}\n${widget.valueUnit}" : "",
        Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: AppLayoutConfig.defaultTextBodyFontSize));
  }

  List<BarChartGroupData> _barChartGroupData() {
    return widget.labels
        .mapIndexed((index, time) => BarChartGroupData(
            showingTooltipIndicators: [0],
            x: index + 1,
            barRods: [
              BarChartRodData(
                  toY: widget.values[index] ?? 0,
                  width: 15,
                  gradient: widget.barGradient.call(context, widget.values[index] ?? 0, _maxValue()))
            ]))
        .toList();
  }
}
