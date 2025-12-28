import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:heart_disease_prediction/models/user_profile.dart';

import '../repository/authentication_repository.dart';

class AuthenticationRepositoryIml extends AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthenticationRepositoryIml(this._firebaseAuth, this._firestore);
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<UserModel> getUserProfile() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        throw Exception('User not logged in');
      }

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        throw Exception('User profile not found');
      }

      return UserModel.fromDocument(doc);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      if (googleUser == null) {
        // User cancelled the login
        throw Exception("Sign-in cancelled.");
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final uid = user.uid;
        final email = user.email;
        final name = user.displayName;
        final photoUrl = user.photoURL;
        final phoneNumber = user.phoneNumber;

        final userModel = UserModel(
          uid: uid,
          name: name!,
          email: email!,
          photoUrl: photoUrl ?? '',
          phoneNumber: phoneNumber ?? '',
        );
        await _firestore
            .collection('users')
            .doc(uid)
            .set(userModel.toMap(), SetOptions(merge: true));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // if (await _googleSignIn.) {
      // Google Sign-Out & Disconnect
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      // 🔒 Optional: Revoke access
      // }

      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception("Google Sign-Out Error: $e");
    }
  }
}
