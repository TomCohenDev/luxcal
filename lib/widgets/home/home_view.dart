import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 30, // Number of containers you want to create
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 200,
            height: 50,
            color: Colors.blue, // You can set the color as per your preference
            margin: EdgeInsets.all(10), // Adjust margin as needed
            child: Center(
              child: Text(
                'Container $index',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
