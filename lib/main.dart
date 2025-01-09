import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'avatar_selection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userData = await DatabaseHelper().getUserData();
  runApp(MyApp(userData: userData));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const MyApp({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: userData == null
          ? const AvatarSelectionScreen()
          : HomeScreen(
              name: userData!['name'],
              avatarIndex: userData!['avatarIndex'],
            ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String name;
  final int avatarIndex;

  const HomeScreen({super.key, required this.name, required this.avatarIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/avatar${avatarIndex + 1}.png',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Hello, $name!",
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
