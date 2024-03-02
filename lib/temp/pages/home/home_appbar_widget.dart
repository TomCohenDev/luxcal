import 'package:flutter/material.dart';

import '../calander/calendar_page.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbarWidget({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      title: const Text('Custom AppBar'),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalendarWidget(),
                ));
          },
          icon: const Icon(Icons.calendar_month),
          label: const Text("calendar"),
        )
      ],
      // You can add more AppBar properties here as needed
    );
  }
}
