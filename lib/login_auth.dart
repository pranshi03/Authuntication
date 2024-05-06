import 'package:authentication/dashboard.dart';
import 'package:authentication/services/google_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  ValueNotifier userCredential = ValueNotifier('');
  GoogleService googleService = GoogleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () {
                    googleService.signInWithGoogle().then((value) => {
                          print("data --->>>$value"),
                          print("data --->>>${value}"),

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard(
                                    data: value,
                                  )),
                              (route) => false)
                        });
                  },
                  style: ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(300, 60))),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset("asset/images/google.png"),
                      ),
                      Text(
                        "Google with Firebase",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
