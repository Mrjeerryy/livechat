import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:livechat/components/Google_sign.dart';
import 'package:livechat/screens/chat_screen.dart';
import 'package:livechat/screens/login_screen.dart';
import 'package:livechat/screens/registration_screen.dart';
import 'package:livechat/components/routes.dart';
import 'package:livechat/screens/welcome_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black54),
          ),
        ),
        // home: WelcomeScreen(),
        initialRoute: route.welcomescreen,
        routes: {
          route.welcomescreen: (context) => const WelcomeScreen(),
          route.loginscreen: (context) => const LoginScreen(),
          route.chatscreen: (context) => ChatScreen(),
          route.registrationscreen: (context) => const RegistrationScreen(),
          route.google_signinscreen: (context) => GoogleSignInScreen()
        });
  }
}
