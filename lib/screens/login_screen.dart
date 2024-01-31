import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livechat/constants.dart';
import 'package:livechat/screens/routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _from = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  late String usereamil;

  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _from,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  usereamil = value;
                  //Do something with the user input.
                },
                decoration: decoration.copyWith(hintText: "Enter your email"),
                validator: (value) {
                  if (value!.contains("@gmail.com")) {
                  } else {
                    return "Enter vaild Email address";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: decoration.copyWith(
                  hintText: "Enter your password",
                ),
                validator: (value) {
                  if (value!.length > 6) {
                  } else {
                    return "password should have at least 6 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      try {
                        auth.signInWithEmailAndPassword(
                            email: usereamil, password: password);
                        Navigator.pushNamed(context, route.chatscreen);
                      } catch (e) {
                        showErrorPopup(context, "incorrect Email or password");
                        print("object");
                      }

                      //Implement login functionality.
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Log In',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
