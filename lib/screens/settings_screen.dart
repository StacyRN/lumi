import 'package:flutter/cupertino.dart';
import 'package:lumi/theme/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                height: 5,
                width: 40,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey4,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Profile
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.person),
                title: const Text('Profile'),
                onTap: () {
                  // Navigation here
                },
              ),

              // Dark Mode toggle
              ValueListenableBuilder<bool>(
                valueListenable: ThemeController.isDarkMode,
                builder: (context, isDark, _) {
                  return CupertinoListTile(
                    leading: const Icon(CupertinoIcons.moon),
                    title: const Text('Dark Mode'),
                    trailing: CupertinoSwitch(
                      value: isDark,
                      onChanged: (value) {
                        ThemeController.isDarkMode.value = value;
                      },
                    ),
                  );
                },
              ),

              // Help & Support
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.question_circle),
                title: const Text('Help & Support'),
                onTap: () {},
              ),

              // Logout
              CupertinoListTile(
                leading: const Icon(CupertinoIcons.square_arrow_right),
                title: const Text('Log Out'),
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: const Text('Log Out'),
                        content: const Text('Are you sure you want to log out?'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            child: const Text('Log Out'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/login',
                                    (route) => false,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CupertinoListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CupertinoListTile({
    super.key,
    required this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 16),
            Expanded(child: title),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
