import 'package:heart_disease_prediction/models/user_profile.dart';

abstract class AuthenticationRepository {
  Future<void> signInWithGoogle();
  Future<void> signOut();
  Future<UserModel> getUserProfile();
}
