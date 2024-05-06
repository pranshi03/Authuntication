import 'package:authentication/services/google_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_util.dart';
import 'login_auth.dart';

class Dashboard extends StatefulWidget {
  final dynamic data;

  const Dashboard({super.key, this.data});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GoogleService googleService = GoogleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            InkWell(
              onTap: () async {
                // Get iosClientId from Google Services JSON
                final iosClientId =
                    await getIosClientIdFromGoogleServicesJson();
                if (iosClientId != null) {
                  // Update Info.plist with iosClientId
                  await updateInfoPlistWithIosClientId(iosClientId);
                } else {
                  print('Failed to get iosClientId from Google Services JSON.');
                }

                // Sign in with Google
                await googleService.signOutGoogle().then((value) =>
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AuthScreen())));
              },
              child: Container(
                width: 100,
                height: 100,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(50)),
                child: ClipOval(
                  child: Image.network(widget.data.photoURL),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Name: ${widget.data.displayName}"),
            SizedBox(
              height: 10,
            ),
            Text("Email: ${widget.data.email}"),
          ],
        ),
      ),
    );
  }
}
