import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show BoxShadow, Colors, LinearGradient;
import 'package:lumi/widgets/bottom_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedRole = 'student';

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

  Widget _buildGradientButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [Color(0xFF8A2BE2), Color(0xFF4169E1)] // Lila zu Blau
                : [CupertinoColors.systemGrey4, CupertinoColors.systemGrey5],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? CupertinoColors.white : CupertinoColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGradientButton(
                    'Student',
                    selectedRole == 'student',
                        () {
                      setState(() {
                        selectedRole = 'student';
                      });
                      handleLogin();
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildGradientButton(
                    'Teacher',
                    selectedRole == 'teacher',
                        () {
                      setState(() {
                        selectedRole = 'teacher';
                      });
                      handleLogin();
                    },
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