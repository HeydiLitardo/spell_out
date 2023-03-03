import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Registrarse con correo electrónico y contraseña
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user!.uid;
    } catch (e) {
      return 'error';
    }
  }

  // Iniciar sesión con correo electrónico y contraseña
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return 'El correo electrónico y la contraseña son obligatorios.';
    }
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      String uid = 'user_uid:' + user.uid;
      return uid;
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Obtener el usuario actualmente autenticado
  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }
}
