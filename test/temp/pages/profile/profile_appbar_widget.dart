import 'package:flutter/material.dart';

class ProfileAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      title: const Text('Custom AppBar'),
      // You can add more AppBar properties here as needed
    );
  }
}
