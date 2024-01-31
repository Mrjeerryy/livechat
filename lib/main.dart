import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:livechat/screens/chat_screen.dart';
import 'package:livechat/screens/login_screen.dart';
import 'package:livechat/screens/registration_screen.dart';
import 'package:livechat/screens/routes.dart';
import 'package:livechat/screens/welcome_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: const TextTheme(
            bodyLarge: const TextStyle(color: Colors.black54),
          ),
        ),
        // home: WelcomeScreen(),
        initialRoute: route.welcomescreen,
        routes: {
          route.welcomescreen: (context) => WelcomeScreen(),
          route.loginscreen: (context) => LoginScreen(),
          route.chatscreen: (context) => ChatScreen(),
          route.registrationscreen: (context) => RegistrationScreen(),
        });
  }
}
