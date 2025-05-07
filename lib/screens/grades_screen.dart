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
    final List<int> counts = [0, 0, 0, 0, 0]; // Index 0 → grade 1, index 4 → grade 5
    final grades = yearlyGrades[selectedYear]!;
    for (var item in grades) {
      int grade = item['grade'];
      if (grade >= 1 && grade <= 5) {
        counts[grade - 1]++;
      }
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Year Dropdown
            DropdownButton<String>(
              value: selectedYear,
              onChanged: (value) {
                setState(() {
                  selectedYear = value!;
                });
              },
              items: yearlyGrades.keys
                  .map((year) => DropdownMenuItem(value: year, child: Text(year)))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Chart
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          return Text(['1', '2', '3', '4', '5'][value.toInt()]);
                        },
                        reservedSize: 28,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                          color: entry.key == 4 ? Colors.red : Colors.green,
                          width: 20,
                        )
                      ],
                    ),
                  )
                      .toList(),
                ),
              ),
            ),

            const SizedBox(height: 24),
            Text(
              'Subjects',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Subject list
            ...yearlyGrades[selectedYear]!.map((item) {
              final grade = item['grade'] as int;
              final subject = item['subject'] as String;
              final isFail = grade == 5;

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: isFail ? Colors.red : Colors.green,
                  child: Text(
                    grade.toString(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  subject,
                  style: theme.textTheme.bodyLarge,
                ),
              );
            }),

            const SizedBox(height: 20),

            // Show More Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Expand logic (optional)
                },
                icon: const Icon(Icons.expand_more),
                label: const Text('Show More'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
