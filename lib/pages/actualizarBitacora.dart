import 'package:dam_u4_proyecto1_18401197/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ActualizarBi extends StatefulWidget {
  const ActualizarBi({Key? key}) : super(key: key);

  @override
  State<ActualizarBi> createState() => _ActualizarBiState();
}

class _ActualizarBiState extends State<ActualizarBi> {
  TextEditingController eventoController = TextEditingController(text: "");
  TextEditingController recursosController = TextEditingController(text: "");
  TextEditingController verificoController = TextEditingController(text: "");

  DateTime selectedFecha = DateTime.now();
  DateTime selectedFechaVerificacion = DateTime.now();

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    if(arguments.isNotEmpty) {
      eventoController.text = arguments["evento"] ?? '';
      recursosController.text = arguments["recursos"] ?? '';
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
              controller: eventoController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.event),
                  labelText: 'Evento'
              ),
            ),
            TextField(
              controller: recursosController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.list),
                  labelText: 'Recursos'
              ),
            ),
            TextField(
              controller: verificoController,
              decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Verificó'
              ),
            ),
            SizedBox(height: 10,),
            TextButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedFecha,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != selectedFecha)
                  setState(() {
                    selectedFecha = picked;
                  });
              },
              child: Text('Seleccionar Fecha: ${DateFormat.yMd().format(selectedFecha)}'),
            ),
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
              await actualizarBitacora(arguments['vehiculoId'],
               eventoController.text,
               recursosController.text,
                selectedFechaVerificacion,).then((_) {
                Navigator.pop(context);
              });
            }, child: const Text("ACTUALIZAR"))
          ],
        ),
      ),
    );
  }
}
