import 'package:flutter/material.dart';
import 'package:spell_out/models/usuarioModel.dart';

class EstudianteDataTable extends StatefulWidget {
  final List<Usuario> estudiantes;
  const EstudianteDataTable({Key? key, required this.estudiantes})
      : super(key: key);

  @override
  _EstudianteDataTableState createState() => _EstudianteDataTableState();
}

class _EstudianteDataTableState extends State<EstudianteDataTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Nombre',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Intentos',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Duracion',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Fecha',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: widget.estudiantes
              .map(
                (estudiante) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(estudiante.nombre!)),
                    DataCell(Text('1')),
                    DataCell(Text('1:30:00')),
                    DataCell(Text('2021-09-01')),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
