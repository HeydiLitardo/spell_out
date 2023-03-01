import 'package:flutter/material.dart';

class FormularioUsuario extends StatefulWidget {
  const FormularioUsuario({Key? key}) : super(key: key);

  @override
  _FormularioUsuarioState createState() => _FormularioUsuarioState();
}

class _FormularioUsuarioState extends State<FormularioUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registro de Estudiante'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(15),
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
                  const TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        hintText: 'Ingrese el nombre del estudiante',
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
                  const TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        hintText: 'Ingrese el apellido del estudiante',
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
                  const TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        hintText: 'Ingrese la cedula del estudiante',
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
                  TextField(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100))
                          .then((value) {
                        print(value);
                      });
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        hintText: 'Ingrese la fecha de nacimiento',
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
                  const TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        hintText: 'Ingrese el correo del estudiante',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor),
                            elevation: MaterialStateProperty.all(0),
                            minimumSize:
                                MaterialStateProperty.all(const Size(380, 56)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)))),
                        child: const Text(
                          'Registrar Estudiante',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ])));
  }
}
