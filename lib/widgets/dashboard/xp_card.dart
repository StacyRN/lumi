import 'package:flutter/cupertino.dart';

class XpCard extends StatelessWidget {
  const XpCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [CupertinoColors.systemBlue, CupertinoColors.systemIndigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x66007AFF), blurRadius: 20, spreadRadius: 0, offset: Offset(0, 8)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('XP Points', style: TextStyle(color: CupertinoColors.white, fontSize: 18)),
          Text('1 230',
              style: theme.textTheme.navLargeTitleTextStyle.copyWith(color: CupertinoColors.white, fontSize: 30)),
        ],
      ),
    );
  }
}