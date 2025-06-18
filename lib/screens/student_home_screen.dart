import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons, Colors, Material;
import 'package:fl_chart/fl_chart.dart';

import '../../widgets/dashboard/dashboard_widgets.dart';

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
      'nextExam': '15 June 2025',
      'homework': 'Page 42, Algebra Problems'
    },
    'English': {
      'teacher': 'Ms. Johnson',
      'grade': 'B+',
      'nextExam': '20 June 2025',
      'homework': 'Essay on Shakespeare’s Hamlet'
    },
    'Science': {
      'teacher': 'Dr. Brown',
      'grade': 'A',
      'nextExam': '22 June 2025',
      'homework': 'Prepare for experiment #4'
    },
    'History': {
      'teacher': 'Mr. Clark',
      'grade': 'B',
      'nextExam': '10 June 2025',
      'homework': 'Summarize WW2 causes'
    },
    'Chemistry': {
      'teacher': 'Dr. Green',
      'grade': 'A+',
      'nextExam': '18 June 2025',
      'homework': 'Lab report due Monday'
    },
    'Art': {
      'teacher': 'Ms. Blue',
      'grade': 'A',
      'nextExam': '25 June 2025',
      'homework': 'Sketch your surroundings'
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
                  DashboardHeader(
                    onNotificationsPressed: () => _showNotificationsPopup(context),
                    onSettingsPressed: () => showCupertinoModalPopup(
                      context: context,
                      builder: (_) => const SettingsScreen(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CupertinoSearchTextField(
                    placeholder: 'Search subjects, homework…',
                    backgroundColor: cardColor,
                  ),
                  const SizedBox(height: 24),
                  const XpCard(),
                  const SizedBox(height: 32),
                  HomeworkList(
                    homeworkStatus: homeworkStatus,
                    subjectDetails: subjectDetails,
                    onStatusChange: (subject, value) {
                      setState(() => homeworkStatus[subject] = value);
                    },
                  ),
                  const SizedBox(height: 32),
                  SubjectsList(subjectDetails: subjectDetails),
                  const SizedBox(height: 32),
                  Text('Grade Distribution',
                      style: theme.textTheme.navTitleTextStyle.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 200, child: GradeChart()),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationsPopup(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Notifications'),
        content: const Text('No notifications.'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
    );
  }
}