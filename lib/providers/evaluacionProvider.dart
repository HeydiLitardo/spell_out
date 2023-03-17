import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:spell_out/data/preguntas.dart';
import 'package:spell_out/models/evaluacionModel.dart';
import 'package:spell_out/services/firebase_firestore_service.dart';

import '../models/actividadModel.dart';

class EvaluacionProvider with ChangeNotifier {
  final FirebaseFirestoreService db = FirebaseFirestoreService();

  List<Actividad> _actividades = [];
  List<Actividad> get actividades => _actividades;

  List<Actividad> bancoPreguntasAbecedario = Preguntas.actividadesAbecedario;
  List<Actividad> bancoPreguntasNumeros = Preguntas.actividadesNumeros;

  Evaluacion _evaluacion = Evaluacion();
  Evaluacion get evaluacion => _evaluacion;

  Actividad _actividad = Actividad();
  Actividad get actividad => _actividad;

  String _respuesta = '';
  String get respuesta => _respuesta;

  bool onEvaluacion = false;
  bool get evaluacionOn => onEvaluacion;

  Future<void> iniciarEvaluacion() async {
    _evaluacion = Evaluacion();
    _actividades = [];
    onEvaluacion = true;
    notifyListeners();
  }

  Future<void> generarEvaluacion() async {
    _evaluacion.actividades = [];
    _evaluacion.nombre = 'Evaluacion abecedario y numeros';
    _evaluacion.descripcion = 'Evaluacion de abecedario y numeros';
    _evaluacion.totalAciertos = 0;
    _evaluacion.totalErrores = 0;
    _evaluacion.puntuacion = 0;
    _evaluacion.actividades = _generarActividades();
    _evaluacion.actividades!.shuffle();
    _actividad = _evaluacion.actividades!.removeAt(0);
    notifyListeners();
  }

  List<Actividad> _generarActividades() {
    List<Actividad> actividades = [];
    // agregar 2 preguntas de cada tipo
    // agregar aleatoriamente 2 preguntas de cada tipo usando random
    for (var i = 0; i < 2; i++) {
      Random random = new Random();
      int indexNumeros = random.nextInt(bancoPreguntasNumeros.length);
      actividades.add(bancoPreguntasNumeros[indexNumeros]);
    }

    for (var i = 0; i <= 2; i++) {
      Random random = new Random();
      int indexAbecedario = random.nextInt(bancoPreguntasAbecedario.length);
      actividades.add(bancoPreguntasAbecedario[indexAbecedario]);
    }
    return actividades;
  }

  void siguientePregunta() {
    if (_evaluacion.actividades!.length > 0) {
      _actividad = _evaluacion.actividades!.removeAt(0);
      debugPrint(_evaluacion.actividades!.length.toString());
    }

    notifyListeners();
  }

  void agregarTotaldeAciertos() {
    _evaluacion.totalAciertos = _evaluacion.totalAciertos! + 1;
    notifyListeners();
  }

  void agregarTotaldeErrores() {
    _evaluacion.totalErrores = _evaluacion.totalErrores! + 1;
    notifyListeners();
  }

  void calcularPuntuacion() {
    _evaluacion.puntuacion = 2.5 * (_evaluacion.totalAciertos!);
    notifyListeners();
  }

  Future<void> capturarRespuesta(String respuesta) async {
    // sacar solo la respuesta del string
    _respuesta = respuesta.split(' ').last;
    notifyListeners();
  }

  Future<void> guardarEvaluacion(String usuarioId) async {
    calcularPuntuacion();
    evaluacion.actividades = [];
    _evaluacion.fecha = DateTime.now();
    onEvaluacion = false;
    if (_evaluacion.puntuacion > 7) {
      _evaluacion.observacion = 'Excelente';
    } else {
      _evaluacion.observacion = 'Requiere mejorar';
    }
    await db.addDocument(
        'usuarios/$usuarioId/evaluaciones', _evaluacion.toJson());
    notifyListeners();
  }
}
