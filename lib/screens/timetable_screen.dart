import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  bool isWeeklyView = true;
  DateTime selectedDate = DateTime.now();

  final Map<String, List<Map<String, String>>> timetableData = {
    '2025-06-21': [
      {
        'subject': 'Rapat dengan Bruce Wayne',
        'teacher': 'Mr. Wayne',
        'room': 'A1',
        'start': '08:00',
        'end': '09:30',
      },
      {
        'subject': 'Test wawasan kebangsaan di Dusun Wakanda',
        'teacher': 'Ms. Shuri',
        'room': 'B2',
        'start': '12:00',
        'end': '13:30',
      },
    ],
    // Füge weitere Daten nach Belieben hinzu...
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
            const SizedBox(height: 3),
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
            'Study for english exam\n12:00 – 16:00',
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
        ? CupertinoColors.systemPurple.withOpacity(0.2)
        : CupertinoColors.activeBlue.withOpacity(0.1);
    final reminderColor = isDark
        ? CupertinoColors.systemPurple.withOpacity(0.2)
        : CupertinoColors.systemBlue;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: const Text('Schedule')),
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
                        Text(DateFormat.E().format(date),
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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: dayClasses.length,
              itemBuilder: (ctx, i) {
                final cls = dayClasses[i];
                return GestureDetector(
                  onTap: () => _showClassDetails(context, cls),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: taskColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      const Icon(CupertinoIcons.book_solid,
                          color: CupertinoColors.extraLightBackgroundGray, size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cls['subject'] ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text('${cls['start']} – ${cls['end']}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: CupertinoColors.inactiveGray)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ClipOval(
                        child: Image.asset(
                          'assets/images/avatar.png',
                          width: 28,
                          height: 28,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ]),
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