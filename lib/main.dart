import 'package:flutter/cupertino.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/student_home_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeController.isDarkMode,
      builder: (context, isDark, _) {
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: CupertinoThemeData(
            brightness: isDark ? Brightness.dark : Brightness.light,
            scaffoldBackgroundColor: isDark
                ? const Color(0xFF121212)
                : CupertinoColors.systemBackground,
            textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(
                color: isDark ? CupertinoColors.white : CupertinoColors.black,
              ),
            ),
            barBackgroundColor: isDark
                ? const Color(0xFF1E1E1E)
                : CupertinoColors.systemGrey6,
            primaryColor: CupertinoColors.activeBlue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/dashboard': (context) => const StudentHomeScreen(),
            '/settings': (context) => const SettingsScreen(),
          },
        );
      },
    );
  }
}
