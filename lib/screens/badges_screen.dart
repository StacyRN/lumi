import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:confetti/confetti.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({super.key});

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  final ConfettiController _confettiController =
  ConfettiController(duration: const Duration(seconds: 1));

  final List<Map<String, dynamic>> achievementsInProgress = [
    {
      'title': 'Completed 5 Assignments',
      'progress': 0.75,
      'image': 'assets/images/badge1.png',
    },
    {
      'title': 'Attended 3 Classes',
      'progress': 0.6,
      'image': 'assets/images/badge2.webp',
    },
    {
      'title': 'Studied 10 Hours',
      'progress': 1.0,
      'image': 'assets/images/badge3.webp',
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

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardColor = isDark
        ? CupertinoColors.systemPurple.withOpacity(0.15)
        : CupertinoColors.systemGrey6;

    final badgeColor = isDark
        ? CupertinoColors.systemPurple.withOpacity(0.2)
        : CupertinoColors.systemGrey5;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Badges'),
      ),
      child: Stack(
        children: [
          SafeArea(
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
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: CupertinoColors.systemPurple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(CupertinoIcons.person_solid,
                          size: 20, color: CupertinoColors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Horizontal scrollable achievement cards
                SizedBox(
                  height: 180,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: achievementsInProgress.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final item = achievementsInProgress[index];
                      final percent = item['progress'] as double;
                      final isComplete = percent >= 1.0;

                      if (isComplete) {
                        Future.delayed(Duration.zero, () {
                          _confettiController.play();
                        });
                      }

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 160,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            LinearPercentIndicator(
                              animation: true,
                              lineHeight: 8.0,
                              percent: percent.clamp(0.0, 1.0),
                              progressColor: CupertinoColors.activeBlue,
                              backgroundColor: CupertinoColors.systemGrey3,
                              barRadius: const Radius.circular(8),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 32),

                // Badge title
                Text(
                  'Badges',
                  style: theme.textTheme.navTitleTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Completed badges
                ...completedBadges.map((badge) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          badge['icon'],
                          size: 32,
                          color: CupertinoColors.activeBlue,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                badge['title'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? CupertinoColors.white
                                      : CupertinoColors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                badge['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark
                                      ? CupertinoColors.systemGrey3
                                      : CupertinoColors.secondaryLabel,
                                ),
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

          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                CupertinoColors.activeBlue,
                CupertinoColors.systemGreen,
                CupertinoColors.systemYellow,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
