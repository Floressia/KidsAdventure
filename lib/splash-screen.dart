import 'package:flutter/material.dart';
import 'avatar_selection.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to AvatarSelectionScreen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) { // Ensure the widget is still in the tree
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AvatarSelectionScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue, // Background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash.png', // Replace with your logo path
                width: 600, // Adjust as needed
                height: 600,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
