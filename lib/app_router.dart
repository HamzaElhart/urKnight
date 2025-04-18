import 'package:flutter/material.dart';
import 'package:urknight/screens/app/contacts/add_contact.dart';
import 'package:urknight/screens/app/contacts/contacts_list.dart';
import 'package:urknight/screens/app/explore/explore_screen.dart';
import 'package:urknight/screens/app/explore/hazard_map.dart';
import 'package:urknight/screens/app/profile/profile_screen.dart';
import 'package:urknight/screens/app/profile/settings_screen.dart';
// import 'package:urknight/screens/app/watch/tutorials_list.dart';
import 'package:urknight/screens/app/watch/video_player.dart';
import 'package:urknight/screens/app/home/HomeScreen.dart';
// import 'package:urknight/screens/emergency_alert.dart';
//import 'package:urknight/screens/spy_camera.dart';
//import 'package:urknight/screens/share_location.dart';
import 'package:urknight/screens/auth/login_screen.dart';
import 'package:urknight/screens/auth/signup_screen.dart';
import 'package:urknight/screens/auth/welcome_screen.dart';
import 'package:urknight/screens/onboarding/onboarding_1.dart';

class AppRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      // case '/emergency_alert':
      //   return MaterialPageRoute(builder: (_) => const EmergencyAlertScreen());
      // case '/spy_camera':
      //   return MaterialPageRoute(builder: (_) => const SpyCameraScreen());
      // case '/share_location':
      //   return MaterialPageRoute(builder: (_) => const ShareLocationScreen());

      // Onboarding Screens
      case '/onboarding_1':
        return MaterialPageRoute(builder: (_) => const Onboarding1());

      // Auth Screens
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      // App Screens (Profile, Contacts, Explore, Watch)
      // case '/contacts/add':
      //   return MaterialPageRoute(builder: (_) => const AddContactScreen());
      case '/contacts/list':
        return MaterialPageRoute(builder: (_) =>  ContactsListScreen());
      // case '/explore':
      //   return MaterialPageRoute(builder: (_) => const ExploreScreen());
      // case '/hazard_map':
      //   return MaterialPageRoute(builder: (_) => const HazardMapScreen());
      // case '/profile':
      //   return MaterialPageRoute(builder: (_) => const ProfileScreen());
      // case '/settings':
      //   return MaterialPageRoute(builder: (_) => const SettingsScreen());
      // case '/tutorials':
      //   return MaterialPageRoute(builder: (_) => const TutorialsListScreen());
      // case '/video_player':
      //   return MaterialPageRoute(builder: (_) => const VideoPlayerScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
