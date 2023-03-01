class Actividad {
  String? id;
  String? nombre;
  String? descripcion;
  String? imagen;
  String? respuesta;

  Actividad(
      {this.id, this.nombre, this.descripcion, this.imagen, this.respuesta});

  factory Actividad.fromJson(Map<String, dynamic> json) {
    return Actividad(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagen: json['imagen'],
      respuesta: json['respuesta'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
        'imagen': imagen,
        'respuesta': respuesta,
      };
}
