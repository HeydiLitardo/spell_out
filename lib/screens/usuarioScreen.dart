import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_out/models/usuarioModel.dart';
import 'package:spell_out/providers/usuarioProvider.dart';

class UsuarioScreen extends StatefulWidget {
  final Function() onCerrarSesion;
  const UsuarioScreen({Key? key, required this.onCerrarSesion})
      : super(key: key);

  @override
  _UsuarioScreenState createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsuarioProvider>().getLetraPorUsuario();
  }

  @override
  Widget build(BuildContext context) {
    Usuario usuario = context.watch<UsuarioProvider>().usuario;
    String imagen = context.watch<UsuarioProvider>().imgUsuario;
    return Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 21,
                  ),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: AssetImage(imagen))),
                  ),
                  const SizedBox(
                    width: 21,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${usuario.nombre} ${usuario.apellido}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text('${usuario.correo}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                      const SizedBox(
                        height: 6,
                      ),
                      Text('${usuario.cedula}',
                          style:
                              const TextStyle(fontSize: 15, color: Colors.grey))
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ListTile(
                minVerticalPadding: 0,
                iconColor: Colors.black,
                onTap: () {},
                leading: const Icon(Icons.person_outline),
                title: const Text(
                  'Informacion del Usuario',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(
                thickness: 1,
              ),
              ListTile(
                minVerticalPadding: 0,
                iconColor: Colors.black,
                onTap: () {},
                leading: const Icon(Icons.question_mark_outlined),
                title: const Text(
                  'Ayuda',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 360,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      widget.onCerrarSesion();
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
                      'Cerrar Sesion',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ])));
  }
}
