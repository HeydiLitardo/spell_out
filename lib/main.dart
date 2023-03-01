import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speechout_app/providers/usuarioProvider.dart';
import 'package:speechout_app/screens/estadisticasScreen.dart';
import 'package:speechout_app/screens/loginScreen.dart';
import 'package:speechout_app/screens/singupScreen.dart';

import 'screens/formularioUsuario.dart';
import 'screens/homeScreen.dart';
import 'widgets/bottomTabNav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Spell Out',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.greenAccent.shade400),
          initialRoute: '/',
          routes: {
            '/': (context) => LoginScreen(),
            '/navigation': (context) => BottomTabNav(

                /// Closing the `build` method.
                ),
            '/login': (context) => LoginScreen(),
            '/singup': (context) => SingupScreen(),
            '/home': (context) => HomeScreen(),
            '/estadisticas': (context) => EstadisticasScreen(),
            '/formularioUsuario': (context) => FormularioUsuario(),
          },
        );
      },
    );
  }
}
