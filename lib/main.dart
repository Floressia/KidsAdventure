import 'package:flutter/material.dart';
import 'splash-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Set initial index to 0 for Home

  // Create a PageController to manage page transitions
  final PageController _pageController = PageController();

  // Method to change the selected index and page view
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index); // Move to the selected page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView or IndexedStack to manage different pages
          IndexedStack(
            index: _selectedIndex,
            children: [
              HomeContent(),  // Home Page
              GamesPage(),    // Games Page
              ProfilePage(),  // Profile Page
            ],
          ),
          // App Bar with fixed logo (only in Home)
          if (_selectedIndex == 0) ...[
            ClipPath(
              clipper: WaveAppBarClipper(), // Use the wave clipper here
              child: Container(
                height: 300,
                color: Colors.lightBlueAccent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/avatar.png'), // Replace with your avatar image
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello,', // First part of the text
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Lemon',
                                ),
                              ),
                              Text(
                                'ADRIANE', // Second part of the text
                                style: TextStyle(
                                  color: Color(0xFF035669),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Lemon',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2), // Adjust the left margin as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Ensures text starts from the left
                          children: [
                            const SizedBox(height: 38),
                            const Text(
                              'START YOUR ADVENTURE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              'Let\'s learn and play!',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Top-right logo (Responsive)
            Positioned(
              top: 40,
              right: 20,
              child: Image.asset(
                'assets/logo.png', // Replace with your logo image path
                width: MediaQuery.of(context).size.width * 0.3, // Adjust width based on screen size
                height: MediaQuery.of(context).size.height * 0.1, // Adjust height based on screen size
                fit: BoxFit.contain, // Ensures the logo maintains its aspect ratio
              ),
            ),
          ],
          // Bottom Navigation Bar just below the content
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Keep the border radius
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Apply the radius to the BottomNavigationBar as well
                child: BottomNavigationBar(
                  currentIndex: _selectedIndex, // Highlight the selected tab
                  onTap: _onItemTapped, // Handle tab selection
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home', // Home is now index 0
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.games),
                      label: 'Games', // Games is now index 1
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                  backgroundColor: Colors.blue, // Set background to transparent
                  elevation: 1, // Remove default elevation
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for the Wave-style AppBar
class WaveAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80); // Start from the bottom left

    // First wave
    path.quadraticBezierTo(
      size.width / 4, size.height, // Control point
      size.width / 2, size.height - 100, // End point
    );

    // Second wave
    path.quadraticBezierTo(
      3 * size.width / 4, size.height - 200, // Control point
      size.width, size.height - 100, // End point
    );

    path.lineTo(size.width, 0); // Move to top right
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Home Page Content
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[50], // Set the background color
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250), // Provide space for the app bar at the top
            Center(
              child: Image.asset(
                'assets/animals.png', // Replace with your image path
                width: 350, // Adjust width as needed
                height: 300, // Adjust height as needed
                fit: BoxFit.contain, // Ensures the image maintains its aspect ratio
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "ALPHABET",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lemon',
                color: Color(0xFFFFB2B3),
              ),
            ),
            const SizedBox(height: 10),
            // Alphabet Carousel
            SizedBox(
              height: 100, // Set the height for the boxes
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 26, // A-Z letters
                itemBuilder: (context, index) {
                  // Get the letter for the current index
                  String letter = String.fromCharCode(65 + index); // ASCII values for A-Z

                  return Container(
                    width: 109, // Width of each box
                    margin: const EdgeInsets.symmetric(horizontal: 8), // Spacing between boxes
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFDCB2FA), // Pink background
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      letter,
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rampart',
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "NUMBERS",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lemon',
                color: Color(0xFFFFB2B3),
              ),
            ),
            const SizedBox(height: 10),
            // Number Carousel
            SizedBox(
              height: 100, // Set the height for the boxes
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Numbers 1-10
                itemBuilder: (context, index) {
                  // Get the number for the current index
                  String number = (index + 1).toString(); // Numbers 1-10

                  return Container(
                    width: 109, // Width of each box
                    margin: const EdgeInsets.symmetric(horizontal: 8), // Spacing between boxes
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFDDA79), // Yellow background
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      number,
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rampart',
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 120), // Add more space at the bottom
          ],
        ),
      ),
    );
  }
}


// Games Page (No AppBar or Logo)
class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Row(
          children: [
            Icon(Icons.videogame_asset, color: Colors.white),
            SizedBox(width: 8), // Space between icon and text
            Text(
              "Games",
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lightBlue[50], // Light blue background
        width: double.infinity, // Ensure full width
        height: double.infinity, // Ensure full height
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 40), // Add space below AppBar
                GridView.builder(
                  shrinkWrap: true, // Prevent GridView from expanding unnecessarily
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling for GridView
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(screenWidth), // Adjust number of columns dynamically
                    crossAxisSpacing: 16, // Space between columns
                    mainAxisSpacing: 16, // Space between rows
                    childAspectRatio: 0.9, // Adjust the aspect ratio for the grid items
                  ),
                  itemCount: 4, // Number of items in the grid
                  itemBuilder: (context, index) {
                    return _buildGameItem(context, _getImagePath(index));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // This function adjusts the number of columns based on screen width
  int _getCrossAxisCount(double screenWidth) {
    if (screenWidth > 600) {
      return 4; // 4 items per row for larger screens
    } else if (screenWidth > 400) {
      return 3; // 3 items per row for medium screens
    } else {
      return 2; // 2 items per row for smaller screens
    }
  }

  // Helper function to get the image path based on index
  String _getImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/PIG.png';
      case 1:
        return 'assets/NUMERO.png';
      case 2:
        return 'assets/COUNT.png';
      case 3:
        return 'assets/SHEP.png';
      default:
        return '';
    }
  }

  Widget _buildGameItem(BuildContext context, String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 10), // Add space above each image
        ClipRRect(
          borderRadius: BorderRadius.circular(15), // Rounded corners for the image
          child: Image.asset(
            imagePath,
            width: 100, // Adjust width for responsive design
            height: 100, // Adjust height for responsive design
            fit: BoxFit.cover, // Ensure the image fits well
          ),
        ),
        SizedBox(height: 10), // Space between image and button
        SizedBox(
          width: 100, // Match the button width to the image
          child: ElevatedButton(
            onPressed: () {
              // Button action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Rounded corners for the button
              ),
              padding: EdgeInsets.symmetric(vertical: 8), // Adjust button padding
            ),
            child: Text('Play'),
          ),
        ),
      ],
    );
  }
}







// Profile Page (No AppBar or Logo)
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Profile Page",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
