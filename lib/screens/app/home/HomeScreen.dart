// ignore: file_names
import 'package:flutter/material.dart';
import 'sos_dialog.dart';
import 'app_bar_widget.dart';
import '../../../widgets/CustomBottomNavBar.dart'; // Ensure this path is correct


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSOSOn = false;
  int selectedIndex = 0; // Track selected index for bottom navigation

  // Handle tap on bottom navigation items
  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    // Navigate to the selected screen based on the index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/contacts/list');
        break;
      // case 2:
      //   Navigator.pushReplacementNamed(context, '/explore');
      //   break;
      // case 3:
      //   Navigator.pushReplacementNamed(context, '/watch');
      //   break;
      // case 4:
      //   Navigator.pushReplacementNamed(context, '/profile');
      //   break;
    }
  }

  void toggleSOS() {
    setState(() {
      isSOSOn = !isSOSOn;
    });
    if (isSOSOn) {
      _showSOSActivatedDialog();
    }
  }

  void _showSOSActivatedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing dialog by tapping outside
      builder: (BuildContext context) {
        return SOSDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        children: [
          // Row at the top with title, description, and image
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Text with title and description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Are you in an emergency?',
                        style: TextStyle(
                          fontSize:
                              22, // Increased font size for better readability
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Press the SOS button, your live location will be shared with the nearest help center and your emergency contacts.',
                        style: TextStyle(
                          fontSize:
                              16, // Increased font size for better readability
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Image on the right with a border radius
                Container(
                  width: 162,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ), // Added border radius
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/crimeImage.jpg',
                      ), // Your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // SOS button and instructions
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SOS Button with an animation effect
                  GestureDetector(
                    onLongPress: () {
                      // You can add the logic for a 3-second long press if needed
                      toggleSOS();
                    },
                    onTap: () {
                      // Optional effect on tap (if needed)
                      toggleSOS();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 300,
                      ), // Smooth transition
                      width: 130, // Increased size for better visibility
                      height: 130,
                      decoration: BoxDecoration(
                        color: isSOSOn ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                isSOSOn ? Colors.greenAccent : Colors.redAccent,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          isSOSOn ? Icons.check : Icons.cancel,
                          color: Colors.white,
                          size: 70, // Increased icon size
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title text for SOS button
                  // const Text(
                  //   'Hold the button for 3 seconds to activate the SOS service',
                  //   style: TextStyle(fontSize: 16),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Custombottomnavbar(
        selectedIndex: selectedIndex, // Pass the selected index
        onTap: onTap, // Pass the onTap function to handle navigation
      ), // Add Custom BottomNavBar here
    );
  }
}
