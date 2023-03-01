class Usuario {
  String? id;
  String? nombre;
  String? apellido;
  String? cedula;
  String? correo;
  String? contrasena;
  DateTime? fechaNacimiento;
  String? rol;

  Usuario(
      {this.id,
      this.nombre,
      this.apellido,
      this.cedula,
      this.correo,
      this.contrasena,
      this.fechaNacimiento, 
      this.rol});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      cedula: json['cedula'],
      correo: json['correo'],
      contrasena: json['contrasena'],
      fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'apellido': apellido,
        'cedula': cedula,
        'correo': correo,
        'contrasena': contrasena,
        'fechaNacimiento': fechaNacimiento!.toIso8601String(),
      };
}
