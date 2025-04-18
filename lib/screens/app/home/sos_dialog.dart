import 'package:flutter/material.dart';
import 'dart:async';

class SOSDialog extends StatefulWidget {
  const SOSDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SOSDialogState createState() => _SOSDialogState();
}

class _SOSDialogState extends State<SOSDialog> {
  bool isSOSActivated = false; // Whether the SOS is activated
  double progress = 0.0; // To track how long the button has been held
  Timer? _timer; // Timer to manage hold duration
  final int holdDuration = 1; // Duration to activate the button (in seconds)

  @override
  void dispose() {
    _timer?.cancel(); // Safely cancel the timer if it exists
    super.dispose();
  }

  void _startHoldTimer() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel(); // Cancel any active timer before starting a new one
    }

    progress = 0.0; // Reset progress each time the timer starts
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        progress += 0.5; // Increment the progress based on the time held
      });

      if (progress >= holdDuration) {
        _timer?.cancel();
        setState(() {
          isSOSActivated = true; // Activate the SOS after 3 seconds
        });
      }
    });
  }

  void _stopHoldTimer() {
    _timer?.cancel(); // Safely cancel the timer on release
    setState(() {
      progress = 0.0; // Reset progress when released
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning, color: Colors.red, size: 80),
            const SizedBox(height: 16),
            const Text(
              'SOS Activated!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your location has been shared with the nearest help center and your emergency contacts.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Circular progress indicator to show the hold duration
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CircularProgressIndicator(
                    value: progress / holdDuration, // Progress value
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                // SOS Button
                GestureDetector(
                  onLongPressStart: (_) {
                    _startHoldTimer(); // Start tracking hold time
                  },
                  onLongPressEnd: (_) {
                    _stopHoldTimer(); // Stop tracking on release
                  },
                  onTap: () {
                    if (isSOSActivated) {
                      Navigator.of(
                        context,
                      ).pop(); // Close the dialog if SOS is activated
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300,
                    ), // Smooth transition
                    width: 130, // Button size
                    height: 130,
                    decoration: BoxDecoration(
                      color: isSOSActivated ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              isSOSActivated
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        isSOSActivated ? Icons.check : Icons.cancel,
                        color: Colors.white,
                        size: 70, // Icon size
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Instruction text for SOS button
            const Text(
              'Hold the button for 1 seconds to activate the SOS service',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
