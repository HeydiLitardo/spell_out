import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spell_out/data/preguntas.dart';
import 'package:spell_out/models/actividadModel.dart';
import 'package:spell_out/services/firebase_auth_service.dart';
import 'package:spell_out/services/firebase_firestore_service.dart';

import '../models/usuarioModel.dart';

final List<Usuario> usuariosInit = [
  Usuario(
      id: '1',
      nombre: 'Profesor',
      apellido: '',
      cedula: '1234567890',
      contrasena: '123456',
      correo: 'profesor@gmail.com',
      rol: 'profesor'),
  Usuario(
    id: '2',
    nombre: 'Estudiante',
    apellido: '',
    cedula: '1234567890',
    contrasena: '123456',
    correo: 'estudiante@gmail.com',
    rol: 'estudiante',
  )
];

class UsuarioProvider with ChangeNotifier {
  final _firebaseAuth = FirebaseAuthService();
  final _firebaseFirestore = FirebaseFirestoreService();
  final List<Actividad> _actividades = Preguntas.actividadesAbecedario;
  String imgUsuario = 'assets/images/alphabeth/0.png';

  late Usuario _usuario;
  Usuario get usuario => _usuario;

  final List<Usuario> _usuarios = usuariosInit;
  List<Usuario> get usuarios => _usuarios;

  String _usuarioIdFirestoreDocumment = '';
  String get usuarioIdFirestoreDocumment => _usuarioIdFirestoreDocumment;

  set usuario(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  Usuario? getUsuario(String correo, String contrasena) {
    return _usuarios.firstWhere(
        (usuario) =>
            usuario.correo == correo && usuario.contrasena == contrasena,
        orElse: () => Usuario());
  }
//autenticacion
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      String result =
          await _firebaseAuth.signInWithEmailAndPassword(email, password);
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  //cerrar sesion
  Future<void> signOut() async {
    _usuario = Usuario();
    await _firebaseAuth.signOut();
  }

  // registrar el usuario en firestore
  Future<void> registrarUsuario(Usuario usuario) async {
    try {
      await _firebaseFirestore.addDocument('usuarios', usuario.toJson());
    } catch (e) {
      print(e);
    }
  }

  // registrar el usuario en firebase auth
  Future<String> registrarUsuarioFirebaseAuth(
      String email, String password) async {
    try {
      String result =
          await _firebaseAuth.createUserWithEmailAndPassword(email, password);
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  // obtener el usuario de firestore
  Future<void> getUsuarioFirestore(String uid) async {
    try {
      List<Map<String, dynamic>> usuarios =
          await _firebaseFirestore.getDocuments('usuarios');
      //obtener el id de referencia del documento
      _usuario = Usuario.fromJson(usuarios.firstWhere(
          (usuario) => usuario['id'] == uid,
          orElse: () => Usuario().toJson()));
      _usuarioIdFirestoreDocumment =
          await _firebaseFirestore.getDocumentIdById('usuarios', _usuario.id!);
    } catch (e) {
      print('Error: ' + e.toString());
    }
  }

  // obtener el usuario actualmente autenticado
  Future<void> getCurrentUser() async {
    try {
      User? user = _firebaseAuth.getCurrentUser();
      if (user != null) {
        String uid = user.uid;
        List<Map<String, dynamic>> usuarios =
            await _firebaseFirestore.getDocuments('usuarios');
        _usuario = Usuario.fromJson(usuarios.firstWhere(
            (usuario) => usuario['id'] == uid,
            orElse: () => Usuario().toJson()));
        getUsuarioFirestore(uid);
      }
    } catch (e) {
      print('Error: ' + e.toString());
    }
  }

  // devolver actividad resultaado en base a la primera letra del usuario
  // si no hay ninguna actividad con la primera letra del usuario
  // devolver la imagen de la actividad encontrada
  void getLetraPorUsuario() {
    if (_usuario.nombre == null) return;
    String letra = _usuario.nombre!.substring(0, 1).toLowerCase();
    Actividad actividad = _actividades.firstWhere(
        (actividad) => actividad.respuesta == letra,
        orElse: () => _actividades.first);
    imgUsuario = actividad.imagen!;
  }
}
