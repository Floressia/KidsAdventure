import 'package:flutter/material.dart';
import 'main.dart';

class AvatarSelectionScreen extends StatefulWidget {
  @override
  _AvatarSelectionScreenState createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  int? selectedAvatar; // Store the index of the selected avatar
  TextEditingController nameController = TextEditingController(); // Controller for the name input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Select your avatar and state your name.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF035669)
, // Set text color to blue
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lemon', // Set font family to Lemon
                ),
              ),
              const SizedBox(height: 40),
              // Avatar selection row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6, // Number of avatars
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 16.0), // Spacing between avatars
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAvatar = index; // Set selected avatar index
                          });
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: selectedAvatar == index
                              ? Colors.greenAccent
                              : Colors.white,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage(
                              'assets/avatar${index + 1}.png', // Replace with your avatar images
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Name input field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter your name here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              const SizedBox(height: 40),
              // Play button
              ElevatedButton(
                onPressed: () {
                  if (selectedAvatar != null && nameController.text.isNotEmpty) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  } else {
                    // Show error if no avatar or name is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please select an avatar and enter your name.",
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF035669)
, // Set button color to blue
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  "Play",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
