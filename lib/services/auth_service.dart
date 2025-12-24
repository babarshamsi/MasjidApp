import 'package:aqimus_salah/models/auth_result_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<AuthResult> signup(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthResult(user: userCredential.user);

    } on FirebaseAuthException catch (exception) {
      return AuthResult(errorMessage: mapAuthError(exception.code));
    }

    catch (exception) {
      return AuthResult(errorMessage: "Something went wrong");
    }
  }

  Future<AuthResult> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthResult(user: userCredential.user);
    }

    on FirebaseAuthException catch (exception) {
      return AuthResult(errorMessage: mapAuthError(exception.code));
    }

    catch (exception) {
      return AuthResult(errorMessage: "Something went wrong");
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

  String mapAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Email already in use';
      case 'weak-password':
        return 'Weak password';
      case 'invalid-credential':
        return 'Invalid email or password';
      case 'user-not-found':
        return 'User not found';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'network-request-failed':
        return 'Network request failed';
      case 'too-many-requests':
        return 'Too many requests';
      case 'Something went wrong':
      default:
        return 'Authentication failed';
    }
  }
}
