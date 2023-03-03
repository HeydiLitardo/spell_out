import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spell_out/models/usuarioModel.dart';
import 'package:spell_out/providers/usuarioProvider.dart';
import 'package:spell_out/screens/loginScreen.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({Key? key}) : super(key: key);

  @override
  _SingupScreenState createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  Usuario usuario = Usuario();
  String _contrasena = '';
  final _formKey = GlobalKey<FormState>();

  bool validarContrasenas(String contrasena, String contrasena2) {
    if (contrasena == contrasena2) {
      return true;
    }
    return false;
  }

  void registrarUsuario(Usuario usuario) {
    context
        .read<UsuarioProvider>()
        .registrarUsuarioFirebaseAuth(usuario.correo!, usuario.contrasena!)
        .then((value) => {
              if (value == 'error')
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('El correo electrónico ya está en uso'),
                  ))
                }
              else
                {
                  usuario.id = value,
                  usuario.rol = 'profesor',
                  context.read<UsuarioProvider>().registrarUsuario(usuario),
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()))
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Registro de Usuario',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
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
                                'Ingrese sus datos para registrarse',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Nombre*',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su nombre';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              usuario.nombre = value;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Ingrese su nombre',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Apellido*',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su apellido';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              usuario.apellido = value;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Ingrese su apellido',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Cedula*',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su cedula';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              usuario.cedula = value;
                            },
                            maxLength: 10,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Ingrese su cedula',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Fecha de nacimiento*',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su fecha de nacimiento';
                              }
                              return null;
                            },
                            controller: TextEditingController(
                                text: usuario.fechaNacimiento == null
                                    ? ''
                                    : DateFormat('dd/MM/yyyy')
                                        .format(usuario.fechaNacimiento!)),
                            readOnly: true,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              ).then((date) {
                                setState(() {
                                  usuario.fechaNacimiento = date;
                                });
                              });
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Ingrese su fecha de nacimiento',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Correo*',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su correo';
                              }
                              if (!value.contains('@')) {
                                return 'Por favor ingrese un correo válido';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              usuario.correo = value;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Ingrese su correo',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Contraseña*',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su contraseña';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              usuario.contrasena = value;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Ingrese su contraseña',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Confirmar contraseña*',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese su contraseña';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _contrasena = value!;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: 'Ingrese su contraseña',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  bool validar = validarContrasenas(
                                      usuario.contrasena ?? '', _contrasena);
                                  if (!validar) {
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Las contraseñas no coinciden')));
                                    }
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    registrarUsuario(usuario);
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Theme.of(context).primaryColor),
                                    elevation: MaterialStateProperty.all(0),
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(360, 56)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18)))),
                                child: const Text(
                                  'Registrarse',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                '¿Ya tienes una cuenta?',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade600),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Inicia sesión',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ])))));
  }
}
