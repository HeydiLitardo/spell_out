import 'dart:collection';

import 'package:flutter/material.dart';
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
  List<Usuario> estudiantes = [
    Usuario(
      id: "1",
      nombre: "Juan Perez",
      correo: "",
      cedula: "",
    ),
    Usuario(
      id: "2",
      nombre: "Maria Lopez",
      correo: "",
      cedula: "",
    ),
    Usuario(
      id: "3",
      nombre: "Pedro Martinez",
      correo: "",
      cedula: "",
    ),
    Usuario(
      id: "4",
      nombre: "Luisa Rodriguez",
      correo: "",
      cedula: "",
    ),
    Usuario(
      id: "5",
      nombre: "Carlos Sanchez",
      correo: "",
      cedula: "",
    ),
  ];
  @override
  Widget build(BuildContext context) {
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
                        _SalesData('Ene', 35),
                        _SalesData('Feb', 28),
                        _SalesData('Mar', 0),
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
