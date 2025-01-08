import 'package:peefo/data/models/authen/authen_model.dart';

abstract class GoogleAuthRepository {
  Future<AuthenModel?> signInWithGoogle();
  Future<void> signOut();
}
