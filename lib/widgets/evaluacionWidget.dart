import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_out/models/evaluacionModel.dart';
import 'package:spell_out/providers/usuarioProvider.dart';
import 'package:spell_out/widgets/preguntaItem.dart';
import 'package:spell_out/widgets/ventanaDialogo.dart';

import '../models/actividadModel.dart';
import '../providers/evaluacionProvider.dart';

class EvaluacionWidget extends StatefulWidget {
  const EvaluacionWidget({Key? key}) : super(key: key);

  @override
  _EvaluacionWidgetState createState() => _EvaluacionWidgetState();
}

class _EvaluacionWidgetState extends State<EvaluacionWidget> {
  Evaluacion _evaluacion = Evaluacion(actividades: []);
  Actividad _actividad = Actividad();
  bool respuesCorrecta = true;
  bool onRespuesta = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {});
  }

  void siguientePregunta() {
    onRespuesta = true;
    cambiarEstadoRespuesta();
    context.read<EvaluacionProvider>().siguientePregunta();
  }

  void evaluaarRespuesta(String respuesta) {
    if (respuesta == _actividad.respuesta) {
      setState(() {
        respuesCorrecta = true;
        onRespuesta = true;
        cambiarEstadoRespuesta();
        context.read<EvaluacionProvider>().siguientePregunta();
        context.read<EvaluacionProvider>().agregarTotaldeAciertos();
      });
    } else {
      setState(() {
        respuesCorrecta = false;
        onRespuesta = true;
        cambiarEstadoRespuesta();
        context.read<EvaluacionProvider>().siguientePregunta();
        context.read<EvaluacionProvider>().agregarTotaldeErrores();
      });
    }
  }

  void cambiarEstadoRespuesta() {
    Timer(
        const Duration(seconds: 2),
        () => setState(() {
              onRespuesta = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    _evaluacion = context.watch<EvaluacionProvider>().evaluacion;
    _actividad = context.watch<EvaluacionProvider>().actividad;
    String id = context.watch<UsuarioProvider>().usuarioIdFirestoreDocumment;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: onRespuesta ? 1 : 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  respuesCorrecta
                      ? const Text('Correcto',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold))
                      : const Text('Incorrecto',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 15,
                  ),
                  respuesCorrecta
                      ? const Icon(Icons.check_circle,
                          color: Colors.green, size: 90)
                      : const Icon(Icons.close, color: Colors.red, size: 90),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          _evaluacion.actividades!.length > 0
              ? PreguntaItem(actividad: _actividad ?? null)
              : const SizedBox(),
          const SizedBox(
            height: 15,
          ),
          _evaluacion.actividades!.length == 0
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text('Aciertos: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text('${_evaluacion.totalAciertos}',
                                  style: const TextStyle(fontSize: 18)),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text('Errores: ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                '${_evaluacion.totalErrores}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                          'Puntaje total: ${_evaluacion.puntuacion.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 30,
          ),
          _evaluacion.actividades!.length == 0
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(200, 50)),
                  onPressed: () {
                    debugPrint('guardar evaluacion: $id');
                    context.read<EvaluacionProvider>().guardarEvaluacion(id);
                  },
                  child: const Text('Guardar evaluación'))
              : const SizedBox(),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const VentanaDialogo()).then((value) {
                  if (value != '' &&
                      value != null &&
                      value.toString().split(' ').length > 1) {
                    evaluaarRespuesta(
                        value.toString().split(' ').last.toLowerCase());
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(), minimumSize: const Size(60, 60)),
              child: const Icon(Icons.mic_outlined, size: 30)),
        ],
      ),
    );
  }
}
