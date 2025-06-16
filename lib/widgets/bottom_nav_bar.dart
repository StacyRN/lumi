import 'package:flutter/cupertino.dart';

// Screens (Pfad ggf. anpassen)
import '../screens/student_home_screen.dart';
import '../screens/grades_screen.dart';
import '../screens/timetable_screen.dart';
import '../screens/badges_screen.dart';



class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // Reihenfolge muss zu den BottomNavigationBarItems passen!
  static final List<Widget> _screens = [
    StudentHomeScreen(), // 0 – Home
    GradesScreen(),      // 1 – Grades
    TimetableScreen(),   // 2 – Timetable
    BadgesScreen(),      // 3 – Badges
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: 'Grades',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.time),
            label: 'Timetable',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.star_circle),
            label: 'Badges',
          ),
        ],
      ),
      tabBuilder: (_, index) {
        return CupertinoTabView(
          builder: (_) => _screens[index],
        );
      },
    );
  }
}
