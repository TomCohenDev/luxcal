import 'package:flutter/material.dart';

import '../calander/calendar_view.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      title: Text('Custom AppBar'),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CalendarWidget(),
                ));
          },
          icon: Icon(Icons.calendar_month),
          label: Text("calendar"),
        )
      ],
      // You can add more AppBar properties here as needed
    );
  }
}
