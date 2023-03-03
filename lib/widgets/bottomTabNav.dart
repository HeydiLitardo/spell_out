import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_out/models/usuarioModel.dart';
import 'package:spell_out/providers/usuarioProvider.dart';
import 'package:spell_out/screens/estadisticasScreen.dart';
import 'package:spell_out/screens/estudiantesScreen.dart';
import 'package:spell_out/screens/homeScreen.dart';
import 'package:spell_out/screens/juegoScreen.dart';
import 'package:spell_out/screens/usuarioScreen.dart';

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
    const HomeScreen(),
    const JuegoScreen(),
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
      icon: Icon(Icons.home),
      label: 'Inicio',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_esports_outlined),
      label: 'Juego',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Usuario',
    ),
  ];

  void initState() {
    super.initState();
    navIndex = 0;
    screens = screensParaEstudiantes;
    items = itemsParaEstudiantes;

    Future.delayed(Duration(seconds: 2)).then((_) {
      Usuario usuario = context.read<UsuarioProvider>().usuario;
      debugPrint('usuario: ${usuario.rol}');
      validarRol(usuario);
    });
  }

  void validarRol(Usuario usuario) {
    if (usuario.rol == 'profesor') {
      setState(() {
        navIndex = 0;
        screens = screensParaProfesores;
        items = itemsParaProfesores;
      });
    } else {
      setState(() {
        screens = screensParaEstudiantes;
        items = itemsParaEstudiantes;
      });
    }
  }

  void onCerrarSesion() {
    setState(() {
      navIndex = 0;
    });
    context.read<UsuarioProvider>().signOut();
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
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
