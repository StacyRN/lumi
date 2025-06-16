import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  String selectedYear = 'SS 2025';

  final Map<String, List<Map<String, dynamic>>> yearlyGrades = {
    'WS 2024': [
      {'subject': 'Math', 'grade': 2},
      {'subject': 'English', 'grade': 3},
      {'subject': 'Science', 'grade': 1},
      {'subject': 'History', 'grade': 5},
      {'subject': 'Art', 'grade': 4},
    ],
    'SS 2024': [
      {'subject': 'Math', 'grade': 1},
      {'subject': 'English', 'grade': 2},
      {'subject': 'Science', 'grade': 1},
      {'subject': 'History', 'grade': 4},
      {'subject': 'Art', 'grade': 2},
    ],
    'WS 2025': [
      {'subject': 'Math', 'grade': 2},
      {'subject': 'English', 'grade': 2},
      {'subject': 'Science', 'grade': 2},
      {'subject': 'History', 'grade': 3},
      {'subject': 'Art', 'grade': 1},
    ],
    'SS 2025': [
      {'subject': 'Math', 'grade': 1},
      {'subject': 'English', 'grade': 1},
      {'subject': 'Science', 'grade': 2},
      {'subject': 'History', 'grade': 2},
      {'subject': 'Art', 'grade': 1},
    ],
  };

  List<int> get gradeCounts {
    final List<int> counts = [0, 0, 0, 0, 0];
    final grades = yearlyGrades[selectedYear] ?? [];
    for (var item in grades) {
      int grade = item['grade'];
      if (grade >= 1 && grade <= 5) {
        counts[grade - 1]++;
      }
    }
    return counts;
  }

  final List<Color> gradeColors = [
    CupertinoColors.systemGreen, // Grade 1
    CupertinoColors.systemGreen.withOpacity(0.6),
    CupertinoColors.systemYellow,
    CupertinoColors.systemOrange,
    CupertinoColors.systemRed, // Grade 5
  ];

  @override
  Widget build(BuildContext context) {
    final grades = yearlyGrades[selectedYear] ?? [];
    final sortedGrades = grades.toList()
      ..sort((a, b) => (a['subject'] as String).compareTo(b['subject'] as String));

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Grades'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown as CupertinoPicker in a GestureDetector
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (_) => SizedBox(
                      height: 250,
                      child: CupertinoPicker(
                        backgroundColor: CupertinoColors.systemBackground,
                        itemExtent: 32,
                        scrollController: FixedExtentScrollController(
                          initialItem:
                          yearlyGrades.keys.toList().indexOf(selectedYear),
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedYear = yearlyGrades.keys.elementAt(index);
                          });
                        },
                        children: yearlyGrades.keys
                            .map((year) => Center(child: Text(year)))
                            .toList(),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.systemGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedYear, style: const TextStyle(fontSize: 16)),
                      const Icon(CupertinoIcons.chevron_down),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Bar chart or no data
              if (grades.isNotEmpty)
                SizedBox(
                  height: 220,
                  child: BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor:
                          CupertinoColors.black.withOpacity(0.8),
                          getTooltipItem: (group, _, rod, __) {
                            return BarTooltipItem(
                              'Note ${group.x + 1}: ${rod.toY.toInt()}x',
                              const TextStyle(color: CupertinoColors.white),
                            );
                          },
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) =>
                                Text((value.toInt() + 1).toString()),
                            reservedSize: 28,
                          ),
                        ),
                        leftTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      barGroups: gradeCounts
                          .asMap()
                          .entries
                          .map(
                            (entry) => BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.toDouble(),
                              color: gradeColors[entry.key],
                              width: 20,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      )
                          .toList(),
                    ),
                  ),
                )
              else
                const Center(
                  child: Text(
                    'Keine Daten für dieses Jahr.',
                    style: TextStyle(color: CupertinoColors.systemGrey),
                  ),
                ),

              const SizedBox(height: 24),

              Text(
                'Subjects',
                style: CupertinoTheme.of(context)
                    .textTheme
                    .navTitleTextStyle
                    .copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // Subject list
              if (grades.isNotEmpty)
                Expanded(
                  child: ListView(
                    children: sortedGrades.map((item) {
                      final grade = item['grade'] as int;
                      final subject = item['subject'] as String;

                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: gradeColors[grade - 1],
                              child: Text(
                                grade.toString(),
                                style: const TextStyle(
                                  color: CupertinoColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(subject,
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'Keine Fächer verfügbar.',
                      style: TextStyle(color: CupertinoColors.systemGrey),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
