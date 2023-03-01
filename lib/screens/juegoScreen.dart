import 'package:flutter/material.dart';
import 'package:speechout_app/models/evaluacionModel.dart';
import 'package:speechout_app/widgets/preguntaItem.dart';

import '../models/actividadModel.dart';

class JuegoScreen extends StatefulWidget {
  const JuegoScreen({Key? key}) : super(key: key);

  @override
  _JuegoScreenState createState() => _JuegoScreenState();
}

class _JuegoScreenState extends State<JuegoScreen> {
  late int intentos = 3;
  late int preguntaIndex = 0;
  late int cantidadPreguntas = 0;
  late Evaluacion evaluacion = Evaluacion(
      id: 1,
      nombre: 'Evaluación 1',
      descripcion: 'Evaluación de prueba',
      fecha: DateTime.now(),
      observacion: '',
      actividades: [
        Actividad(
            id: '1',
            nombre: 'Actividad 1',
            descripcion: 'Actividad de prueba',
            imagen: 'assets/images/alphabeth/d.png',
            respuesta: 'Respuesta 1'),
        Actividad(
            id: '2',
            nombre: 'Actividad 2',
            descripcion: 'Actividad de prueba',
            imagen: 'assets/images/alphabeth/h.png',
            respuesta: 'Respuesta 2'),
        Actividad(
            id: '3',
            nombre: 'Actividad 3',
            descripcion: 'Actividad de prueba',
            imagen: 'assets/images/alphabeth/g.png',
            respuesta: 'Respuesta 3'),
        Actividad(
            id: '4',
            nombre: 'Actividad 4',
            descripcion: 'Actividad de prueba',
            imagen: 'assets/images/alphabeth/i.png',
            respuesta: 'Respuesta 4'),
      ]);

  @override
  void initState() {
    super.initState();
    cantidadPreguntas = evaluacion.actividades!.length;
  }

  void siguietePregunta() {
    if (preguntaIndex < cantidadPreguntas - 1) {
      setState(() {
        preguntaIndex++;
      });
    } else {
      setState(() {
        preguntaIndex = 0;
      });
    }
  }

  bool evaluarPregunta(String respuesta) {
    if (evaluacion.actividades![preguntaIndex].respuesta == respuesta) {
      siguietePregunta();
      return true;
    } else {
      setState(() {
        intentos--;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text('Juego',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text('Intentos:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                      width: 90,
                      height: 30,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Icon(Icons.favorite,
                              color:
                                  index < intentos ? Colors.red : Colors.grey);
                        },
                        itemCount: intentos,
                        scrollDirection: Axis.horizontal,
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              PreguntaItem(actividad: evaluacion.actividades![preguntaIndex]),
              const SizedBox(
                height: 15,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 5),
                            blurRadius: 10)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Respuesta Correcta',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Icon(
                        Icons.check_circle_outline,
                        size: 90,
                        color: Colors.greenAccent,
                      )
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        siguietePregunta();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(60, 60),
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15)),
                      child: const Icon(Icons.mic_none)),
                ],
              )
            ]));
  }
}
