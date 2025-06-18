import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({super.key});

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  final List<Map<String, dynamic>> achievementsInProgress = [
    {
      'title': 'Completed 5 Assignments',
      'progress': 0.75,
      'image': 'assets/images/star.png',
    },
    {
      'title': 'Attended 3 Classes',
      'progress': 0.6,
      'image': 'assets/images/speech.png',
    },
    {
      'title': 'Studied 10 Hours',
      'progress': 1.0,
      'image': 'assets/images/assignment.png',
    },
  ];

  final List<Map<String, dynamic>> completedBadges = const [
    {
      'title': 'Super Learner',
      'description': 'Completed 10 study sessions',
      'icon': CupertinoIcons.star_fill,
    },
    {
      'title': 'Early Bird',
      'description': 'Studied before 7am',
      'icon': CupertinoIcons.sun_max_fill,
    },
    {
      'title': 'Marathon',
      'description': 'Studied for 5 hours straight',
      'icon': CupertinoIcons.timer,
    },
  ];

  final List<Map<String, dynamic>> lockedBadges = const [
    {
      'title': 'Night Owl',
      'description': 'Studied after midnight',
    },
    {
      'title': 'Perfectionist',
      'description': '100% score on all tasks',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Badges'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hello, Student!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: const [
                    Icon(CupertinoIcons.bolt_fill, size: 18, color: CupertinoColors.systemYellow),
                    SizedBox(width: 4),
                    Text('1230 XP', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 202,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: achievementsInProgress.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = achievementsInProgress[index];
                  final percent = item['progress'] as double;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 160,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          CupertinoColors.systemYellow,
                          Color(0xFFFFE0F0), // sehr hellrosa
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey4,
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(item['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item['title'],
                          style: theme.textTheme.textStyle.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        CircularPercentIndicator(
                          radius: 32.0,
                          lineWidth: 6.0,
                          percent: percent.clamp(0.0, 1.0),
                          progressColor: CupertinoColors.systemPurple,
                          backgroundColor: CupertinoColors.systemGrey4,
                          center: Text('${(percent * 100).toInt()}%',
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            Text(
              'Achievements',
              style: theme.textTheme.navTitleTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            ...completedBadges.map((badge) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      CupertinoColors.systemPurple,
                      CupertinoColors.systemBlue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      badge['icon'],
                      size: 32,
                      color: CupertinoColors.systemYellow,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            badge['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            badge['description'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),
            Text(
              'Locked Achievements',
              style: theme.textTheme.navTitleTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            ...lockedBadges.map((badge) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey5,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.lock_fill,
                        size: 32, color: CupertinoColors.systemGrey),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Locked Achievement',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: CupertinoColors.systemGrey)),
                          Text(
                            'Unlock this by completing more tasks',
                            style: TextStyle(
                                fontSize: 13,
                                color: CupertinoColors.systemGrey2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}