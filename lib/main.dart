import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:urknight/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UrKnight',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Define the starting route (e.g., WelcomeScreen)
      onGenerateRoute: AppRouter.generateRoute, // Use the AppRouter for route management
    );
  }
}
