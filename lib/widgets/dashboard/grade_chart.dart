import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class GradeChart extends StatelessWidget {
  const GradeChart({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final labels = ['1', '2', '3', '4', '5'];
    final colors = [
      CupertinoColors.systemGreen,
      CupertinoColors.systemBlue,
      CupertinoColors.systemYellow,
      CupertinoColors.systemOrange,
      CupertinoColors.systemRed,
    ];

    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: CupertinoColors.black.withOpacity(0.8),
            getTooltipItem: (group, _, rod, __) =>
                BarTooltipItem('Grade ${group.x + 1}\n${rod.toY.toInt()}×', const TextStyle(color: CupertinoColors.white)),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (v, _) => Text(labels[v.toInt()],
                  style: TextStyle(
                      color: isDark ? CupertinoColors.white : CupertinoColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: List.generate(
          5,
              (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: 5 - i.toDouble(),
                color: colors[i],
                width: 22,
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colors[i].withOpacity(0.6), width: 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}