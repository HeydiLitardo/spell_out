import 'package:flutter/material.dart';
import 'package:speechout_app/models/actividadModel.dart';

class PreguntaItem extends StatefulWidget {
  final Actividad actividad;

  const PreguntaItem({Key? key, required this.actividad}) : super(key: key);

  @override
  _PreguntaItemState createState() => _PreguntaItemState();
}

class _PreguntaItemState extends State<PreguntaItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 5),
                blurRadius: 10)
          ]),
      child: Column(
        children: [
          Text(
            widget.actividad.nombre!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset(widget.actividad.imagen!, width: 150, height: 150),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
