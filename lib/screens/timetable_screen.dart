import 'package:flutter/material.dart';
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
    '2025-05-05': [
      {
        'subject': 'Math',
        'teacher': 'Mr. Johnson',
        'room': '101',
        'start': '08:00',
        'end': '09:30',
      },
      {
        'subject': 'English',
        'teacher': 'Ms. Smith',
        'room': '102',
        'start': '10:00',
        'end': '11:30',
      },
    ],
    '2025-05-06': [
      {
        'subject': 'Physics',
        'teacher': 'Dr. Albert',
        'room': '202',
        'start': '09:00',
        'end': '10:30',
      },
    ],
  };

  void _showClassDetails(Map<String, String> subject) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () => Navigator.of(ctx).pop(),
                  child: const Icon(Icons.close, size: 24),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject['subject'] ?? '', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text('Teacher: ${subject['teacher']}'),
                  Text('Room: ${subject['room']}'),
                  Text('Time: ${subject['start']} - ${subject['end']}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DateTime> _getWeekDates(DateTime selectedDay) {
    final startOfWeek = selectedDay.subtract(Duration(days: selectedDay.weekday - 1));
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = _getWeekDates(selectedDate);
    final dayKey = DateFormat('yyyy-MM-dd').format(selectedDate);
    final dayClasses = timetableData[dayKey] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
        actions: [
          IconButton(
            icon: Icon(isWeeklyView ? Icons.view_day : Icons.view_week),
            onPressed: () {
              setState(() {
                isWeeklyView = !isWeeklyView;
              });
            },
            tooltip: isWeeklyView ? 'Switch to Daily View' : 'Switch to Weekly View',
          ),
        ],
      ),
      body: Column(
        children: [
          if (isWeeklyView)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (ctx, i) {
                  final date = weekDates[i];
                  final isSelected = DateFormat('yyyy-MM-dd').format(date) == dayKey;
                  return GestureDetector(
                    onTap: () => setState(() => selectedDate = date),
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(DateFormat.E().format(date), style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(DateFormat.Md().format(date)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: dayClasses.length,
              itemBuilder: (ctx, index) {
                final subject = dayClasses[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    onTap: () => _showClassDetails(subject),
                    leading: const Icon(Icons.book, color: Colors.blueAccent),
                    title: Text(subject['subject'] ?? ''),
                    subtitle: Text('${subject['start']} - ${subject['end']}'),
                    trailing: Text(subject['room'] ?? ''),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
