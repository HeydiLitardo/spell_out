import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spell_out/models/usuarioModel.dart';

import '../providers/usuarioProvider.dart';

class FormularioUsuario extends StatefulWidget {
  const FormularioUsuario({Key? key}) : super(key: key);

  @override
  _FormularioUsuarioState createState() => _FormularioUsuarioState();
}

class _FormularioUsuarioState extends State<FormularioUsuario> {
  final _formKey = GlobalKey<FormState>();
  Usuario usuario = Usuario();

  void RegistrarUsuarioEstudiante() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      usuario.rol = 'estudiante';
      usuario.contrasena = usuario.cedula;
      usuario.referencia = context.read<UsuarioProvider>().usuario.id;
      context
          .read<UsuarioProvider>()
          .registrarUsuarioFirebaseAuth(usuario.correo!, usuario.contrasena!)
          .then((value) => {
                if (value == 'error')
                  {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('El correo electrónico ya está en uso'),
                    ))
                  }
                else
                  {
                    usuario.id = value,
                    context.read<UsuarioProvider>().registrarUsuario(usuario),
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('El estudiante se ha registrado'),
                    )),
                    Navigator.pop(context),
                  }
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registro de Estudiante'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
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
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            hintText: 'Ingrese el nombre del estudiante',
                            hintStyle: TextStyle(color: Colors.grey)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el nombre del estudiante';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          usuario.nombre = value;
                        },
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
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            hintText: 'Ingrese el apellido del estudiante',
                            hintStyle: TextStyle(color: Colors.grey)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el apellido del estudiante';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          usuario.apellido = value;
                        },
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
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            hintText: 'Ingrese la cedula del estudiante',
                            hintStyle: TextStyle(color: Colors.grey)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la cedula del estudiante';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          usuario.cedula = value;
                        },
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
                            hintText:
                                'Ingrese la fecha de nacimiento del estudiante',
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
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            hintText: 'Ingrese el correo del estudiante',
                            hintStyle: TextStyle(color: Colors.grey)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el correo del estudiante';
                          }
                          if (value.contains('@') == false) {
                            return 'Por favor ingrese un correo valido';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          usuario.correo = value;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              RegistrarUsuarioEstudiante();
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
                              'Registrar Estudiante',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('La contraseña se generara automaticamente, ',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade600)),
                        ],
                      ),
                    ]))));
  }
}
