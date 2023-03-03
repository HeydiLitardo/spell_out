import 'actividadModel.dart';

class Evaluacion {
  int? id;
  String? nombre;
  String? descripcion;
  DateTime? fecha;
  String? observacion;
  int? totalAciertos;
  int? totalErrores;
  double puntuacion = 0.0;
  List<Actividad>? actividades;

  Evaluacion({
    this.id,
    this.nombre,
    this.descripcion,
    this.fecha,
    this.observacion,
    this.totalAciertos,
    this.totalErrores,
    this.puntuacion = 0.0,
    this.actividades,
  });

  factory Evaluacion.fromJson(Map<String, dynamic> json) {
    return Evaluacion(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      observacion: json['observacion'],
      totalAciertos: json['totalAciertos'],
      totalErrores: json['totalErrores'],
      puntuacion: json['puntuacion'],
      actividades: json['actividades'] != null
          ? (json['actividades'] as List)
              .map((e) => Actividad.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'fecha': fecha,
      'observacion': observacion,
      'totalAciertos': totalAciertos,
      'totalErrores': totalErrores,
      'puntuacion': puntuacion,
      'actividades': actividades,
    };
  }
}
