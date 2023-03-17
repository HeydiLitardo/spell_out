import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_out/providers/datosProvider.dart';
import 'package:spell_out/providers/usuarioProvider.dart';
import 'package:spell_out/widgets/estudianteDataTable.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/usuarioModel.dart';

class EstadisticasScreen extends StatefulWidget {
  const EstadisticasScreen({Key? key}) : super(key: key);

  @override
  _EstadisticasScreenState createState() => _EstadisticasScreenState();
}

class _EstadisticasScreenState extends State<EstadisticasScreen> {
  List<Usuario> estudiantes = [];
  @override
  Widget build(BuildContext context) {
    estudiantes = context.watch<UsuarioProvider>().usuariosFirestore;
    return Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SizedBox(
                  height: 30,
                ),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Estadisticas de las actividades'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  isTransposed: true,
                  series: <ChartSeries<_SalesData, String>>[
                    BarSeries<_SalesData, String>(
                      color: Theme.of(context).primaryColor,
                      dataSource: <_SalesData>[
                        _SalesData('Ene', 0),
                        _SalesData('Feb', 0),
                        _SalesData(
                            'Mar',
                            context
                                .watch<DatosProvider>()
                                .totalEvaluciones
                                .toDouble()),
                        _SalesData('Abr', 0),
                        _SalesData('May', 0)
                      ],
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      dataLabelSettings: DataLabelSettings(isVisible: false),
                      isVisibleInLegend: false,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Listado de Estudiantes',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                EstudianteDataTable(estudiantes: estudiantes)
              ])),
        ));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
