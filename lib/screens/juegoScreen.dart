import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spell_out/models/evaluacionModel.dart';
import 'package:spell_out/widgets/evaluacionWidget.dart';
import 'package:spell_out/widgets/preguntaItem.dart';

import '../models/actividadModel.dart';
import '../providers/evaluacionProvider.dart';

class JuegoScreen extends StatefulWidget {
  const JuegoScreen({Key? key}) : super(key: key);

  @override
  _JuegoScreenState createState() => _JuegoScreenState();
}

class _JuegoScreenState extends State<JuegoScreen> {
  void iniciarEvaluacion() {
    Future.delayed(Duration.zero, () {
      context.read<EvaluacionProvider>().iniciarEvaluacion();
      context.read<EvaluacionProvider>().generarEvaluacion();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool onEvaluacion = context.watch<EvaluacionProvider>().onEvaluacion;
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !onEvaluacion
                ? SizedBox(
                    height: 30,
                  )
                : SizedBox(
                    height: 0,
                  ),
            !onEvaluacion
                ? Text('Evaluación',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                : SizedBox(
                    height: 0,
                  ),
            SizedBox(
              height: 30,
            ),
            !onEvaluacion
                ? ElevatedButton(
                    onPressed: () {
                      iniciarEvaluacion();
                    },
                    child: Text('Iniciar Evaluación',
                        style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 0,
                  ),
            onEvaluacion ? EvaluacionWidget() : SizedBox(),
          ],
        ),
      ),
    );
  }
}
