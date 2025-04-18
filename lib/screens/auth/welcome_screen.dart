import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  double _overlayOpacity = 0;

  @override
  void initState() {
    super.initState();

    // Fade-in animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Slide-up text animation controller
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    // Start animations in sequence
    _fadeController.forward().whenComplete(() {
      setState(() {
        _overlayOpacity = 0.5;
      });
      _slideController.forward();
    });

    // After 2 seconds, navigate
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with fade-in
          FadeTransition(
            opacity: _fadeController,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/welcome_screen.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Green overlay with animated opacity
          AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: _overlayOpacity,
            child: Container(color: const Color.fromARGB(144, 21, 212, 63)),
          ),

          // Content with slide animation
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset("assets/images/logo.png")),
              const SizedBox(height: 20),
              SlideTransition(
                position: _slideAnimation,
                child: const Text.rich(
                  TextSpan(
                    text: "Hope for ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontFamily: "poppins",
                    ),
                    children: [
                      TextSpan(
                        text: "Humanity",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom Text
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  "Welcome to hope for humanity",
                  style: const TextStyle(
                    fontSize: 29.18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
