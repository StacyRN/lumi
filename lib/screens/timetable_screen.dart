import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  DateTime selectedDate = DateTime.now(); // Zeigt immer aktuelle Woche an

  final Map<String, List<Map<String, String>>> timetableData = {
    '2025-06-18': [
      {
        'subject': 'Math',
        'teacher': 'Mr. Müller',
        'room': 'R101',
        'start': '08:00',
        'end': '09:30',
      },
      {
        'subject': 'Biology',
        'teacher': 'Ms. Schmidt',
        'room': 'R205',
        'start': '10:00',
        'end': '11:30',
      },
      {
        'subject': 'History',
        'teacher': 'Mr. Bauer',
        'room': 'R310',
        'start': '12:00',
        'end': '13:30',
      },
    ],
  };

  List<DateTime> _getWeekDates(DateTime date) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  void _showClassDetails(BuildContext context, Map<String, String> cls) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(cls['subject'] ?? ''),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text('Teacher: ${cls['teacher']}'),
            Text('Room: ${cls['room']}'),
            Text('Time: ${cls['start']} – ${cls['end']}'),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Close'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    );
  }

  Widget _reminderTile(Color bg) {
    return Container(
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(children: const [
        Icon(CupertinoIcons.calendar, color: CupertinoColors.white),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            'Study for English exam\n12:00 – 16:00',
            style: TextStyle(color: CupertinoColors.white),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final weekDates = _getWeekDates(selectedDate);
    final dayKey = DateFormat('yyyy-MM-dd').format(selectedDate);
    final dayClasses = timetableData[dayKey] ?? [];

    final taskColor = isDark
        ? CupertinoColors.systemPurple.withOpacity(0.15)
        : CupertinoColors.systemPurple.withOpacity(0.07);
    final reminderColor = isDark
        ? CupertinoColors.systemPurple.withOpacity(0.2)
        : CupertinoColors.systemPurple;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Schedule')),
      child: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),
          SizedBox(
            height: 76,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: weekDates.length,
              itemBuilder: (ctx, i) {
                final date = weekDates[i];
                final isSel = DateFormat('yyyy-MM-dd').format(date) == dayKey;
                return GestureDetector(
                  onTap: () => setState(() => selectedDate = date),
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSel
                          ? theme.primaryColor
                          : CupertinoColors.systemGrey5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat.E('en_US').format(date),
                            style: TextStyle(
                                color: isSel
                                    ? CupertinoColors.white
                                    : CupertinoColors.label,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(DateFormat.d().format(date),
                            style: TextStyle(
                                color: isSel
                                    ? CupertinoColors.white
                                    : CupertinoColors.secondaryLabel,
                                fontSize: 16)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text('Schedule Today',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: dayClasses.isEmpty
                ? const Center(
              child: Text(
                'No classes scheduled for today.',
                style: TextStyle(color: CupertinoColors.inactiveGray),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: dayClasses.length,
              itemBuilder: (ctx, i) {
                final cls = dayClasses[i];
                return GestureDetector(
                  onTap: () => _showClassDetails(context, cls),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: taskColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${cls['start']}\n${cls['end']}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: CupertinoColors.systemGrey)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cls['subject'] ?? '',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 6),
                                Text('Teacher: ${cls['teacher']}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors.systemGrey)),
                                Text('Room: ${cls['room']}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: CupertinoColors.systemGrey)),
                              ]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Reminder',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text("Don't forget schedule for tomorrow",
                style: TextStyle(color: CupertinoColors.inactiveGray)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(children: [
              _reminderTile(reminderColor),
              const SizedBox(height: 8),
              _reminderTile(reminderColor),
            ]),
          ),
          Center(
            child: CupertinoButton(
              color: CupertinoColors.lightBackgroundGray,
              borderRadius: BorderRadius.circular(24),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
              child: const Text('Set schedule'),
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}