import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

class DashboardHeader extends StatelessWidget {
  final VoidCallback onNotificationsPressed;
  final VoidCallback onSettingsPressed;

  const DashboardHeader({
    super.key,
    required this.onNotificationsPressed,
    required this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

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
          onPressed: onNotificationsPressed,
          child: Icon(Icons.notifications_none, color: theme.primaryColor),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onSettingsPressed,
          child: Icon(Icons.settings, color: theme.primaryColor),
        ),
      ],
    );
  }
}