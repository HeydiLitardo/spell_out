import 'package:flutter/material.dart';

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
  late Usuario _usuario;
  Usuario get usuario => _usuario;

  final List<Usuario> _usuarios = usuariosInit;
  List<Usuario> get usuarios => _usuarios;

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
}
