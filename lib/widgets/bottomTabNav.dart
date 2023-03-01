import 'package:flutter/material.dart';
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
  final screens = [
    const HomeScreen(),
    const EstadisticasScreen(),
    const EstudiantesScreen(),
    const UsuarioScreen()
  ];

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
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined), label: 'Estadisticas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined), label: 'Estudiantes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Usuario'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
