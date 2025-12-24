import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signup(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (exception) {
      print("Signup error:  $exception");
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (exception) {
      print("Login error:  $exception");
      return null;
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    User? user = auth.currentUser;
    return user;
  }

  Stream<User?> get userStream {
    return auth.authStateChanges();
  }
}

