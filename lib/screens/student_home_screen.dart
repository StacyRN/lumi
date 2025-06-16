// lib/screens/student_home_screen.dart
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons; // nur für Icons-Konstanten
import 'package:fl_chart/fl_chart.dart';
import 'settings_screen.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  final Map<String, bool> homeworkStatus = {
    'Math': true,
    'English': false,
    'Physics': false,
    'Chemistry': true,
    'Art': false,
  };

  final Map<String, Map<String, String>> subjectDetails = {
    'Math': {
      'teacher': 'Mr. Smith',
      'grade': 'A-',
      'nextExam': '15 June 2025'
    },
    'English': {
      'teacher': 'Ms. Johnson',
      'grade': 'B+',
      'nextExam': '20 June 2025'
    },
    'Science': {
      'teacher': 'Dr. Brown',
      'grade': 'A',
      'nextExam': '22 June 2025'
    },
    'History': {
      'teacher': 'Mr. Clark',
      'grade': 'B',
      'nextExam': '10 June 2025'
    },
    'Chemistry': {
      'teacher': 'Dr. Green',
      'grade': 'A+',
      'nextExam': '18 June 2025'
    },
    'Art': {
      'teacher': 'Ms. Blue',
      'grade': 'A',
      'nextExam': '25 June 2025'
    },
  };

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF101012) : CupertinoColors.systemGroupedBackground;
    final cardColor = isDark ? const Color(0xFF1E1E20) : CupertinoColors.secondarySystemGroupedBackground;

    return CupertinoPageScaffold(
      backgroundColor: bgColor,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Dashboard'),
        border: null,
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
                  _buildHeader(theme, context),
                  const SizedBox(height: 20),
                  _buildSearch(cardColor),
                  const SizedBox(height: 24),
                  _buildXpCard(theme),
                  const SizedBox(height: 32),
                  _buildHomework(context, theme),
                  const SizedBox(height: 32),
                  _buildSubjects(context, isDark),
                  const SizedBox(height: 32),
                  _buildChartTitle(theme),
                  const SizedBox(height: 200, child: _GradeChart()),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(CupertinoThemeData theme, BuildContext context) {
    return Row(
      children: [
        Hero(
          tag: 'profile',
          child: ClipOval(
            child: Image.asset('assets/images/profile.png', width: 52, height: 52, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text('Hello, Student 👋',
              style: theme.textTheme.navTitleTextStyle.copyWith(fontWeight: FontWeight.w600)),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: Icon(Icons.notifications_none, color: theme.primaryColor),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => showCupertinoModalPopup(
            context: context,
            builder: (_) => const SettingsScreen(),
          ),
          child: Icon(Icons.settings, color: theme.primaryColor),
        ),
      ],
    );
  }

  Widget _buildSearch(Color cardColor) => CupertinoSearchTextField(
    placeholder: 'Search subjects, homework…',
    backgroundColor: cardColor,
  );

  Widget _buildXpCard(CupertinoThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [CupertinoColors.systemBlue, CupertinoColors.systemIndigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x66007AFF), blurRadius: 20, spreadRadius: 0, offset: Offset(0, 8)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('XP Points', style: TextStyle(color: CupertinoColors.white, fontSize: 18)),
          Text('1 230',
              style: theme.textTheme.navLargeTitleTextStyle.copyWith(color: CupertinoColors.white, fontSize: 30)),
        ],
      ),
    );
  }

  Widget _buildHomework(BuildContext ctx, CupertinoThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Homework', style: theme.textTheme.navTitleTextStyle.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: homeworkStatus.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final subject = homeworkStatus.keys.elementAt(index);
              final done = homeworkStatus[subject]!;

              return GestureDetector(
                onTap: () => setState(() => homeworkStatus[subject] = !done),
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done
                            ? CupertinoColors.systemGreen.withOpacity(0.28)
                            : CupertinoColors.systemBlue.withOpacity(0.20),
                        border: Border.all(
                          color: done ? CupertinoColors.systemGreen : CupertinoColors.systemBlue,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          done ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.book_solid,
                          color: done ? CupertinoColors.systemGreen : CupertinoColors.systemBlue,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubjects(BuildContext ctx, bool isDark) {
    final subjects = subjectDetails.keys.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Subjects',
            style: CupertinoTheme.of(ctx).textTheme.navTitleTextStyle.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: subjects.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final subject = subjects[index];
              final color = CupertinoColors.activeBlue;
              return GestureDetector(
                onTap: () => _showSubjectDetails(ctx, subject),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 240),
                  width: 160,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: isDark ? color.withOpacity(0.30) : color.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Text(subject,
                        style: CupertinoTheme.of(ctx)
                            .textTheme
                            .textStyle
                            .copyWith(fontWeight: FontWeight.w600, fontSize: 16)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showSubjectDetails(BuildContext context, String subject) {
    final details = subjectDetails[subject]!;
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(subject),
        content: Column(
          children: [
            const SizedBox(height: 8),
            Text('Teacher: ${details['teacher']}'),
            Text('Grade: ${details['grade']}'),
            Text('Next Exam: ${details['nextExam']}'),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildChartTitle(CupertinoThemeData theme) =>
      Text('Grade Distribution', style: theme.textTheme.navTitleTextStyle.copyWith(fontWeight: FontWeight.w600));
}

class _GradeChart extends StatelessWidget {
  const _GradeChart();

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
                BarTooltipItem('Grade ${group.x + 1}\n${rod.toY.toInt()}×',
                    const TextStyle(color: CupertinoColors.white)),
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
