import 'package:flutter/material.dart';
import 'package:spell_out/models/charDataModel.dart';
import 'package:spell_out/models/evaluacionModel.dart';
import 'package:spell_out/services/firebase_firestore_service.dart';

class DatosProvider with ChangeNotifier {
  final FirebaseFirestoreService _firebaseFirestore =
      FirebaseFirestoreService();

  List<ChartDataModel> _data = [
    ChartDataModel('Aciertos', 5),
    ChartDataModel('Errores', 3),
  ];
  List<ChartDataModel> get data => _data;

  double _porcentajeAciertos = 0.0;
  double get porcentajeAciertos => _porcentajeAciertos;
  double _porcentajeErrores = 0.0;
  double get porcentajeErrores => _porcentajeErrores;

  Future<void> getData(String idUsuario) async {
    try {
      List<Map<String, dynamic>> evaluaciones = await _firebaseFirestore
          .getDocuments('/usuarios/$idUsuario/evaluaciones');

      if (evaluaciones.isEmpty) {
        _data[0].y = 5.0;
        _data[1].y = 2.0;
        _porcentajeAciertos = 0.0;
        _porcentajeErrores = 0.0;
        notifyListeners();
        return;
      }

      List<Evaluacion> _evaluaciones = evaluaciones
          .map((evaluacion) => Evaluacion.fromJson(evaluacion))
          .toList();
      int totalAciertos = 0;
      int totalErrores = 0;
      evaluaciones.forEach((evaluacion) {
        totalAciertos += evaluacion['totalAciertos'] as int;
        totalErrores += evaluacion['totalErrores'] as int;
      });
      _data[0].y = double.parse(totalAciertos.toString());
      _data[1].y = double.parse(totalErrores.toString());
    } catch (e) {
      _porcentajeAciertos = 0.0;
      _porcentajeErrores = 0.0;
      print(e);
    }

    notifyListeners();
  }

  void calcularPorcentajes() {
    _porcentajeAciertos = (_data[0].y / (_data[0].y + _data[1].y)) * 100;
    _porcentajeErrores = (_data[1].y / (_data[0].y + _data[1].y)) * 100;
    notifyListeners();
  }
}
