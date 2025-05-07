import 'package:flutter/material.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({super.key});

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  final List<Map<String, dynamic>> unlockedBadges = [
    {'name': 'Homework Hero', 'icon': Icons.check_circle, 'color': Colors.orange},
    {'name': '5 XP Streak', 'icon': Icons.local_fire_department, 'color': Colors.redAccent},
  ];

  final List<Map<String, dynamic>> lockedBadges = [
    {'name': '7 Day Streak', 'icon': Icons.lock, 'color': Colors.grey},
    {'name': '10 Homeworks', 'icon': Icons.lock, 'color': Colors.grey},
  ];

  List<bool> badgeVisible = [];

  @override
  void initState() {
    super.initState();
    badgeVisible = List.filled(unlockedBadges.length, false);

    for (int i = 0; i < unlockedBadges.length; i++) {
      Future.delayed(Duration(milliseconds: 200 * i), () {
        if (mounted) {
          setState(() {
            badgeVisible[i] = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Badges'),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // XP Summary
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: isDark ? Colors.blue[900] : Colors.blue[50],
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total XP: 2150',
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('🔥 Streak: 3 days in a row!', style: textTheme.bodyMedium),
                    Text('📈 Earned 120 XP this week.', style: textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Unlocked Badges',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(unlockedBadges.length, (index) {
                final badge = unlockedBadges[index];
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: badgeVisible[index] ? 1.0 : 0.0,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 500),
                    scale: badgeVisible[index] ? 1.0 : 0.8,
                    curve: Curves.easeOutBack,
                    child: _buildBadge(
                      context: context,
                      icon: badge['icon'],
                      label: badge['name'],
                      color: badge['color'],
                      isLocked: false,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),

            Text(
              'Locked Badges',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: lockedBadges
                  .map((badge) => _buildBadge(
                context: context,
                icon: badge['icon'],
                label: badge['name'],
                color: badge['color'],
                isLocked: true,
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required bool isLocked,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: isLocked
              ? (isDark ? Colors.grey[800] : Colors.grey[300])
              : color,
          child: Icon(
            icon,
            size: 30,
            color: isLocked ? Colors.grey[500] : Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isLocked
                ? (isDark ? Colors.grey[500] : Colors.grey[600])
                : (isDark ? Colors.white : Colors.black),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
