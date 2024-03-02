import 'package:LuxCal/src/ui/widgets/custom_scaffold.dart';
import 'package:LuxCal/src/ui/widgets/splash_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          ..._backgroundCircles(),
          _body(),
        ],
      ),
    );
  }

  List<Widget> _backgroundCircles() {
    return [
      Positioned(
        top: -60,
        left: -60,
        child: CircleAvatar(
          backgroundColor: Color(0xff1C9FE9),
          radius: 90,
        ),
      ),
      Positioned(
        bottom: 135,
        right: -50,
        child: CircleAvatar(
          backgroundColor: Color(0xff86D8CA),
          radius: 45,
        ),
      ),
      Positioned(
        bottom: -35,
        right: 350,
        child: CircleAvatar(
          backgroundColor: Color(0xffFCB833),
          radius: 40,
        ),
      ),
    ];
  }

  Widget _body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 48.0,
          backgroundColor: Colors.orangeAccent,
          child: Text(
            'LuxCal',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        SizedBox(height: 48),
        Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        SizedBox(height: 48),
        TextField(
          decoration: InputDecoration(
            fillColor: Colors.white24,
            filled: true,
            hintText: 'yourname123@gmail.com',
            prefixIcon: Icon(Icons.email, color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 16),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            fillColor: Colors.white24,
            filled: true,
            hintText: '**********',
            prefixIcon: Icon(Icons.lock, color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 24),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            child: Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              // Handle forgot password
            },
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          child: Text(
            'Sign In',
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.purple, // Background color
            onPrimary: Colors.white, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          onPressed: () {
            // Handle sign in
          },
        ),
      ],
    );
  }
}
