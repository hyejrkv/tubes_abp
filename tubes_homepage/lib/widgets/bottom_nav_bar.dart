import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.home, color: Color(0xFF373F9D)),
            Icon(Icons.calendar_today),
            SizedBox(width: 40), // Untuk FAB
            Icon(Icons.star_border),
            Icon(Icons.person_outline),
          ],
        ),
      ),
    );
  }
}
