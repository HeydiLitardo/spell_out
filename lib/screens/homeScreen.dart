import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_out/models/usuarioModel.dart';
import 'package:spell_out/providers/datosProvider.dart';
import 'package:spell_out/providers/usuarioProvider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/charDataModel.dart';
import '../providers/evaluacionProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TooltipBehavior _tooltip;
  List<ChartDataModel> data = [];

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
    String idUsuario =
        context.read<UsuarioProvider>().usuarioIdFirestoreDocumment;

    Future.delayed(Duration.zero, () {
      context.read<UsuarioProvider>().getCurrentUser();
      if (context.read<UsuarioProvider>().usuario.rol == 'estudiante') {
        context.read<DatosProvider>().getData(idUsuario);
      }
      context.read<DatosProvider>().calcularPorcentajes();
      context.read<UsuarioProvider>().getEstudiantes();
    });
  }

  @override
  Widget build(BuildContext context) {
    Usuario usuario = context.watch<UsuarioProvider>().usuario;
    data = context.watch<DatosProvider>().data;
    double porcentajeAciertos =
        context.watch<DatosProvider>().porcentajeAciertos;
    double porcentajeErrores = context.watch<DatosProvider>().porcentajeErrores;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SfCircularChart(
                  title: ChartTitle(text: 'Cantidad de intentos por aciertos'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: _tooltip,
                  series: <CircularSeries>[
                    DoughnutSeries<ChartDataModel, String>(
                      dataSource: data,
                      xValueMapper: (ChartDataModel data, _) => data.x,
                      yValueMapper: (ChartDataModel data, _) => data.y,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                    )
                  ],
                )),
            const SizedBox(
              height: 21,
            ),
            usuario.rol == 'profesor'
                ? Container(
                    padding: const EdgeInsets.all(21),
                    height: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Usuarios',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(45, 171, 193, 1),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${context.watch<UsuarioProvider>().usuariosFirestore.length}',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.people_alt_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 21,
            ),
            Container(
              padding: const EdgeInsets.all(21),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Porcentaje de aciertos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(45, 193, 119, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${porcentajeAciertos.toStringAsFixed(2)} %',
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.check_circle_outline_outlined,
                    size: 50,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(21),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Porcentaje de errores',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(193, 45, 45, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${porcentajeErrores.toStringAsFixed(2)} %',
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.cancel_outlined,
                    size: 50,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 21,
            ),
          ],
        ),
      ),
    );
  }
}
