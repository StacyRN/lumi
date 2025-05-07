import 'package:flutter/material.dart';
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
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
    } else {
      // No navigation for teacher yet
      debugPrint("Teacher mode selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
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
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedRole = 'student';
                  });
                  handleLogin(); // Navigate only for student
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedRole == 'student'
                      ? Colors.blue
                      : Colors.grey.shade300,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Log In as Student'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedRole = 'teacher';
                  });
                  // Just change color, no navigation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedRole == 'teacher'
                      ? Colors.blue
                      : Colors.grey.shade300,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Log In as Teacher'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
