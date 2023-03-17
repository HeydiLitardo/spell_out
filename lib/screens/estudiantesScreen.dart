import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_out/models/usuarioModel.dart';
import 'package:spell_out/providers/usuarioProvider.dart';

class EstudiantesScreen extends StatefulWidget {
  const EstudiantesScreen({Key? key}) : super(key: key);

  @override
  _EstudiantesScreenState createState() => _EstudiantesScreenState();
}

class _EstudiantesScreenState extends State<EstudiantesScreen> {
  List<Usuario> usuariosEstudiantes = [];

  @override
  void initState() {
    super.initState();
  }

  void deleteUsuario(String id) {
    context.read<UsuarioProvider>().eliminarUsuario(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Usuario eliminado"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    usuariosEstudiantes = context.watch<UsuarioProvider>().usuariosFirestore;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Estudiantes",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Lista de estudiantes",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/formularioUsuario",
                          arguments: Usuario());
                    },
                    child: const Text("Agregar Estudiante"))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: usuariosEstudiantes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: ListTile(
                      title: Text(
                          "${usuariosEstudiantes[index].nombre} ${usuariosEstudiantes[index].apellido}"),
                      subtitle:
                          Text("Cedula: ${usuariosEstudiantes[index].cedula}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/formularioUsuario",
                                  arguments: usuariosEstudiantes[index]);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteUsuario(usuariosEstudiantes[index].id!);
                              setState(() {
                                usuariosEstudiantes.removeAt(index);
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
