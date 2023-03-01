import 'actividadModel.dart';

class Evaluacion {
  int? id;
  String? nombre;
  String? descripcion;
  DateTime? fecha;
  String? observacion;
  int? totalAciertos;
  int? totalErrores;
  List<Actividad>? actividades;

  Evaluacion(
      {this.id,
      this.nombre,
      this.descripcion,
      this.fecha,
      this.observacion,
      this.totalAciertos,
      this.totalErrores,
      this.actividades});

  factory Evaluacion.fromJson(Map<String, dynamic> json) {
    var list = json['actividades'] as List;
    List<Actividad> actividadesList =
        list.map((i) => Actividad.fromJson(i)).toList();

    return Evaluacion(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      fecha: json['fecha'],
      observacion: json['observacion'],
      totalAciertos: json['totalAciertos'],
      totalErrores: json['totalErrores'],
      actividades: actividadesList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
        'fecha': fecha,
        'observacion': observacion,
        'totalAciertos': totalAciertos,
        'totalErrores': totalErrores,
        'actividades': actividades,
      };
}
