import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto1_18401197/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ActualizarBi extends StatefulWidget {
  const ActualizarBi({Key? key}) : super(key: key);

  @override
  State<ActualizarBi> createState() => _ActualizarBiState();
}

class _ActualizarBiState extends State<ActualizarBi> {
  TextEditingController verificoController = TextEditingController(text: "");
  TextEditingController fechaverificacionController = TextEditingController(text: "");

  DateTime selectedFecha = DateTime.now();
  DateTime selectedFechaVerificacion = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    final vehiculoId = arguments["vehiculoId"] ?? '';
    final bitacoraId = arguments["bitacoraId"] ?? '';
    if(arguments.isNotEmpty) {
      verificoController.text = arguments["verifico"] ?? '';
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar bitacora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: verificoController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.list),
                  labelText: 'Persona que verificó'
              ),
            ),
            SizedBox(height: 10,),
            TextButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedFechaVerificacion,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedFechaVerificacion)
                  setState(() {
                    selectedFechaVerificacion = picked;
                  });
              },
              child: Text('Seleccionar Fecha de Verificación: ${DateFormat.yMd().format(selectedFechaVerificacion)}'),
            ),
            ElevatedButton(onPressed: () async{
              await actualizarBitacora(
                vehiculoId,
                  bitacoraId,
                  verificoController.text,
                selectedFechaVerificacion , ).then((_) {
                Navigator.pop(context);
              });
            }, child: const Text("ACTUALIZAR"))
          ],
        ),
      ),
    );
  }
}
