// google_auth.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class GoogleService {
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(user!.uid == currentUser!.uid);

      print('signInWithGoogle succeeded: $user');

      return user;
    } catch (error) {
      print('signInWithGoogle failed: $error');
      return null;
    }
  }

  Future<void> signOutGoogle() async {
    try {
      await googleSignIn.signOut();
      await _auth.signOut();
      print('User signed out successfully');
    } catch (error) {
      print('signOutGoogle failed: $error');
    }
  }
}
