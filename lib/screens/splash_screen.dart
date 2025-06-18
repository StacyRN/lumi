import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static String routeName = '/splashScreen';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: CupertinoColors.white,
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            image: AssetImage('assets/images/splash_screen.png'),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0.0, 0.73),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(40),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    'LogIn',
                    style: GoogleFonts.interTight(
                      fontSize: 20,
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
