import 'dart:ui';
import 'package:flutter/cupertino.dart';

class HomeworkList extends StatelessWidget {
  final Map<String, bool> homeworkStatus;
  final Map<String, Map<String, String>> subjectDetails;
  final void Function(String subject, bool done) onStatusChange;

  const HomeworkList({
    super.key,
    required this.homeworkStatus,
    required this.subjectDetails,
    required this.onStatusChange,
  });

  void _showHomeworkDetails(BuildContext context, String subject) {
    final details = subjectDetails[subject]!;
    final done = homeworkStatus[subject]!;
    showCupertinoDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) => CupertinoAlertDialog(
          title: Text('Homework for $subject'),
          content: Column(
            children: [
              const SizedBox(height: 8),
              Text('Teacher: ${details['teacher']}'),
              Text('Subject: $subject'),
              Text('Homework: ${details['homework']}'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Done'),
                  CupertinoSwitch(
                    value: done,
                    onChanged: (val) {
                      Navigator.of(context).pop();
                      onStatusChange(subject, val);
                    },
                  ),
                ],
              )
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

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
                onTap: () => _showHomeworkDetails(context, subject),
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
}