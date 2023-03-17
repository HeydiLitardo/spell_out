import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_out/models/evaluacionModel.dart';
import 'package:spell_out/models/usuarioModel.dart';
import 'package:spell_out/providers/datosProvider.dart';

class EstudianteDataTable extends StatefulWidget {
  final List<Usuario> estudiantes;
  const EstudianteDataTable({Key? key, required this.estudiantes})
      : super(key: key);

  @override
  _EstudianteDataTableState createState() => _EstudianteDataTableState();
}

class _EstudianteDataTableState extends State<EstudianteDataTable> {
  List<int> aciertos = [];
  List<int> errores = [];
  List<int> totalEvaluciones = [];

  @override
  void initState() {
    super.initState();
    aciertos = List.filled(widget.estudiantes.length, 0);
    errores = List.filled(widget.estudiantes.length, 0);
    totalEvaluciones = List.filled(widget.estudiantes.length, 0);
    getEvaluaciones();
  }

  getEvaluaciones() async {
    widget.estudiantes.forEach((estudiante) async {
      List<Evaluacion> evaluaciones = await context
          .read<DatosProvider>()
          .getEvaluaciones(await context
              .read<DatosProvider>()
              .getUsuarioFirestore(estudiante.id!));
      int aciertosEstudiante = 0;
      int erroresEstudiante = 0;
      evaluaciones.forEach((evaluacion) {
        aciertosEstudiante += evaluacion.totalAciertos!;
        erroresEstudiante += evaluacion.totalErrores!;
        totalEvaluciones[widget.estudiantes.indexOf(estudiante)]++;
      });
      Future.delayed(Duration.zero, () async {
        setState(() {
          aciertos[widget.estudiantes.indexOf(estudiante)] = aciertosEstudiante;
          errores[widget.estudiantes.indexOf(estudiante)] = erroresEstudiante;
        });
        context
            .read<DatosProvider>()
            .addTotalPorcentajesEstudiantes(aciertos, errores);
        context.read<DatosProvider>().calcularPorcentajes();
      });
    });
  }

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
                'Total de Aciertos',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Total de Errores',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: widget.estudiantes
              .map(
                (estudiante) => DataRow(
                  cells: <DataCell>[
                    DataCell(GestureDetector(
                      onTap: () {
                        context.read<DatosProvider>().setTotalEvaluaciones(
                            totalEvaluciones[
                                widget.estudiantes.indexOf(estudiante)]);
                      },
                      child: Text(
                        '${estudiante.nombre} ${estudiante.apellido}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    )),
                    DataCell(Text(
                        '${aciertos[widget.estudiantes.indexOf(estudiante)] ?? 0}')),
                    DataCell(Text(
                        '${errores[widget.estudiantes.indexOf(estudiante)] ?? 0}')),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
