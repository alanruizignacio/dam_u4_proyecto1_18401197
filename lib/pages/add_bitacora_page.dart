import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/firebase_service.dart';

class AddBitacora extends StatefulWidget {
  final String vehiculoId;

  const AddBitacora({Key? key, required this.vehiculoId}) : super(key: key);

  @override
  State<AddBitacora> createState() => _AddBitacoraState();
}

class _AddBitacoraState extends State<AddBitacora> {
  TextEditingController  eventocontroller = TextEditingController(text: "");
  TextEditingController  recursoscontroller = TextEditingController(text: "");
  TextEditingController  verificocontroller = TextEditingController(text: "");

  DateTime selectedFecha = DateTime.now();
  DateTime selectedFechaVerificacion = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Insertar biacora'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                controller: eventocontroller,
                decoration: const InputDecoration(
                    icon: Icon(Icons.event),
                    labelText: 'Evento'
                ),
              ),
              TextField(
                controller: recursoscontroller,
                decoration: const InputDecoration(
                    icon: Icon(Icons.list),
                    labelText: 'Recursos'
                ),
              ),
              TextField(
                controller: verificocontroller,
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
                await insertarBitacora(widget.vehiculoId, {
                  "evento": eventocontroller.text,
                  "recursos": recursoscontroller.text,
                  "verifico": verificocontroller.text,
                  "fecha": selectedFecha,
                  "fechaverificacion": selectedFechaVerificacion,
                }).then((_) {
                  Navigator.pop(context);
                });
              }, child: const Text("Insertar"))
            ],
          ),
        ),
      );
  }
}
