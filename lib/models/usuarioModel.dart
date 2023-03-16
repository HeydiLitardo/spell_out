class Usuario {
  String? id;
  String? nombre;
  String? apellido;
  String? cedula;
  String? correo;
  String? contrasena;
  DateTime? fechaNacimiento;
  String? rol;
  String? referencia;

  Usuario({
    this.id,
    this.nombre,
    this.apellido,
    this.cedula,
    this.correo,
    this.contrasena,
    this.fechaNacimiento,
    this.rol,
    this.referencia,
  });

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    apellido = json['apellido'];
    cedula = json['cedula'];
    correo = json['correo'];
    contrasena = json['contrasena'];
    rol = json['rol'];
    referencia = json['referencia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['apellido'] = this.apellido;
    data['cedula'] = this.cedula;
    data['correo'] = this.correo;
    data['contrasena'] = this.contrasena;
    data['fechaNacimiento'] = this.fechaNacimiento!.toIso8601String();
    data['rol'] = this.rol;
    data['referencia'] = this.referencia;
    return data;
  }
}
