import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/usuarioModel.dart';
import '../providers/usuarioProvider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Usuario usuario = Usuario();

  final correoController = TextEditingController();
  final contrasenaController = TextEditingController();

  void iniciarSesion() {
    usuario.correo = correoController.text;
    usuario.contrasena = contrasenaController.text;
    context
        .read<UsuarioProvider>()
        .signInWithEmailAndPassword(usuario.correo!, usuario.contrasena!)
        .then((value) {
      if (value == 'El correo electrónico y la contraseña son obligatorios.') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value),
        ));
        return;
      }
      if (value.contains('user_uid:')) {
        context.read<UsuarioProvider>().usuario = usuario;
        Navigator.pushNamed(context, '/navigation');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Correo o contraseña incorrectos'),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [
            //     Image(
            //       image: AssetImage('assets/images/logo1.jpg'),
            //       height: 150,
            //     )
            //   ],
            // ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Inicio de sesion',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ingrese sus datos para iniciar sesion',
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Correo',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: correoController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  hintText: 'Ingrese su correo',
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Contraseña',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              obscureText: true,
              controller: contrasenaController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  hintText: 'Ingrese su contraseña',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    iniciarSesion();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor),
                      elevation: MaterialStateProperty.all(0),
                      minimumSize:
                          MaterialStateProperty.all(const Size(360, 56)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)))),
                  child: const Text(
                    'Iniciar Sesion',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  '¿No tiene una cuenta?',
                  style: TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/singup');
                  },
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
