import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../providers/evaluacionProvider.dart';

class VentanaDialogo extends StatefulWidget {
  const VentanaDialogo({Key? key}) : super(key: key);

  @override
  _VentanaDialogoState createState() => _VentanaDialogoState();
}

class _VentanaDialogoState extends State<VentanaDialogo> {
  final _speech = stt.SpeechToText();
  String _textoTranscrito = '';
  String _textoEscrito = 'Escuchando...';
  

  void _iniciarCapturaDeVoz() async {
    if (_speech.isAvailable) {
      await _speech.listen(
        localeId: 'es_ES',
        onResult: (result) {
          setState(() {
            _textoTranscrito = result.recognizedWords;
            debugPrint(_textoTranscrito);
            _textoEscrito = 'Voz capturada: $_textoTranscrito';
          });
        },
      );
    } else {
      _textoEscrito = 'El reconocimiento de voz no está disponible';
    }
  }

  @override
  void initState() {
    super.initState();
    _speech.initialize(
      onStatus: (status) {
        // manejar cambios en el estado del reconocimiento de voz
      },
      onError: (error) {
        // manejar errores
      },
      // configurar el modelo de lenguaje para español
    );
    _iniciarCapturaDeVoz();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Hable ahora'),
      content: Text('${_textoEscrito}'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_textoTranscrito);
          },
          child: Text('Aceptar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
      ],
    );
  }
}
