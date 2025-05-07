import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'settings_screen.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final homeworkItems = [
      {'subject': 'Math', 'done': true},
      {'subject': 'English', 'done': false},
      {'subject': 'Physics', 'done': false},
      {'subject': 'Chemistry', 'done': true},
      {'subject': 'Art', 'done': false},
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to profile screen
                    },
                    child: const CircleAvatar(
                      radius: 26,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Hello, Student 👋",
                      style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const SettingsScreen(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search subjects, homework...',
                  prefixIcon: const Icon(Icons.search),
                  fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // XP Card
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.indigoAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('XP Points', style: TextStyle(color: Colors.white, fontSize: 18)),
                    Text(
                      '1,230',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text('Homework', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),

              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: homeworkItems.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final item = homeworkItems[index];
                    final done = item['done'] as bool;
                    final subject = item['subject'] as String;

                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              title: Text(subject),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Due: May 12, 2025"),
                                  const SizedBox(height: 8),
                                  const Text("Assignment: Complete the practice worksheet."),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                        ),
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text("Submit as...", style: TextStyle(fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 16),
                                                ListTile(
                                                  leading: const Icon(Icons.picture_as_pdf),
                                                  title: const Text("PDF File"),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                    // TODO: Add PDF submission logic
                                                  },
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons.camera_alt),
                                                  title: const Text("Take Photo"),
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                    // TODO: Add photo submission logic
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text("Submit"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: done
                                      ? Colors.green.withOpacity(0.25)
                                      : Colors.blueAccent.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: done ? Colors.green : Colors.blueAccent,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    done ? Icons.check : Icons.menu_book_outlined,
                                    color: done ? Colors.green : Colors.blueAccent,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              Text('Subjects', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  _subjectCard(context, 'Math', Colors.orange),
                  _subjectCard(context, 'English', Colors.green),
                  _subjectCard(context, 'Science', Colors.purple),
                  _subjectCard(context, 'History', Colors.red),
                  _subjectCard(context, 'PE', Colors.teal),
                  _subjectCard(context, 'Chemistry', Colors.indigo),
                  _subjectCard(context, 'Art', Colors.pink),
                ],
              ),
              const SizedBox(height: 32),

              Text('Grade Distribution', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 200, child: _GradeChart()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subjectCard(BuildContext context, String name, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? color.withOpacity(0.25) : color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Center(
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _GradeChart extends StatelessWidget {
  const _GradeChart();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final labels = ['1', '2', '3', '4', '5'];
    final colors = [Colors.green, Colors.blue, Colors.orange, Colors.purple, Colors.red];

    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                return Text(
                  labels[value.toInt()],
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: List.generate(5, (i) {
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: 5 - i.toDouble(),
                width: 18,
                color: colors[i],
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }),
      ),
    );
  }
}
