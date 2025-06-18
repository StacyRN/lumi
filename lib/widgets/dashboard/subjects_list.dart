import 'package:flutter/cupertino.dart';

class SubjectsList extends StatelessWidget {
  final Map<String, Map<String, String>> subjectDetails;

  const SubjectsList({super.key, required this.subjectDetails});

  void _showSubjectDetails(BuildContext context, String subject) {
    final details = subjectDetails[subject]!;
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(subject),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text('Teacher: ${details['teacher']}'),
              Text('Grade: ${details['grade']}'),
              Text('Next Exam: ${details['nextExam']}'),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Close'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final subjects = subjectDetails.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Subjects',
            style: CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(fontWeight: FontWeight.w600)),
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
                onTap: () => _showSubjectDetails(context, subject),
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
                        style: CupertinoTheme.of(context)
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
}