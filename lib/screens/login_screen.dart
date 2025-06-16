import 'package:flutter/cupertino.dart';
import 'package:lumi/widgets/bottom_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedRole = 'student'; // default selection

  void handleLogin() {
    if (selectedRole == 'student') {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const BottomNavBar()),
      );
    } else {
      debugPrint("Teacher mode selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Login'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login as:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    color: selectedRole == 'student'
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.systemGrey4,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    onPressed: () {
                      setState(() {
                        selectedRole = 'student';
                      });
                      handleLogin();
                    },
                    child: const Text('Student'),
                  ),
                  const SizedBox(width: 20),
                  CupertinoButton(
                    color: selectedRole == 'teacher'
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.systemGrey4,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    onPressed: () {
                      setState(() {
                        selectedRole = 'teacher';
                      });
                    },
                    child: const Text('Teacher'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
