import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_out/providers/datosProvider.dart';
import 'package:spell_out/providers/evaluacionProvider.dart';
import 'package:spell_out/providers/usuarioProvider.dart';
import 'package:spell_out/screens/estadisticasScreen.dart';
import 'package:spell_out/screens/loginScreen.dart';
import 'package:spell_out/screens/singupScreen.dart';

import 'screens/formularioUsuario.dart';
import 'screens/homeScreen.dart';
import 'widgets/bottomTabNav.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => EvaluacionProvider()),
        ChangeNotifierProvider(create: (_) => DatosProvider())
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
