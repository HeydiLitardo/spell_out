import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speechout_app/models/usuarioModel.dart';
import 'package:speechout_app/providers/usuarioProvider.dart';
import 'package:speechout_app/screens/estadisticasScreen.dart';
import 'package:speechout_app/screens/estudiantesScreen.dart';
import 'package:speechout_app/screens/homeScreen.dart';
import 'package:speechout_app/screens/juegoScreen.dart';
import 'package:speechout_app/screens/usuarioScreen.dart';

class BottomTabNav extends StatefulWidget {
  const BottomTabNav({Key? key}) : super(key: key);

  @override
  _BottomTabNavState createState() => _BottomTabNavState();
}

class _BottomTabNavState extends State<BottomTabNav> {
  int navIndex = 0;
  late List<StatefulWidget> screensParaProfesores = [
    const HomeScreen(),
    const EstadisticasScreen(),
    const EstudiantesScreen(),
    UsuarioScreen(onCerrarSesion: onCerrarSesion)
  ];

  late List<StatefulWidget> screensParaEstudiantes = [
    const JuegoScreen(),
    const EstadisticasScreen(),
    UsuarioScreen(
      onCerrarSesion: onCerrarSesion,
    )
  ];

  List<Widget> screens = [];
  List<BottomNavigationBarItem> items = [];

  List<BottomNavigationBarItem> itemsParaProfesores = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Inicio',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
      label: 'Estadísticas',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'Estudiantes',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Usuario',
    ),
  ];

  List<BottomNavigationBarItem> itemsParaEstudiantes = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.gamepad),
      label: 'Juego',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
      label: 'Estadísticas',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Usuario',
    ),
  ];

  void initState() {
    super.initState();
    navIndex = 0;
    screens = screensParaProfesores;
    items = itemsParaProfesores;
  }

  void validarRol(Usuario usuario) {
    if (usuario.rol == 'profesor') {
      screens = screensParaProfesores;
      items = itemsParaProfesores;
    } else {
      screens = screensParaEstudiantes;
      items = itemsParaEstudiantes;
    }
  }

  void onCerrarSesion() {
    setState(() {
      navIndex = 0;
    });
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    Usuario usuario = context.watch<UsuarioProvider>().usuario;
    validarRol(usuario);
    return Scaffold(
      body: screens[navIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: navIndex,
        onTap: (index) => setState(() {
          navIndex = index;
        }),
        items: items,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
