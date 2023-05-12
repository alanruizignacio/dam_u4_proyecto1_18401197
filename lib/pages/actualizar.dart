import 'package:dam_u4_proyecto1_18401197/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Actualizar extends StatefulWidget {
  const Actualizar({Key? key}) : super(key: key);

  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {

  TextEditingController placaController = TextEditingController(text: "");
  TextEditingController tipoController = TextEditingController(text: "");
  TextEditingController numserieController = TextEditingController(text: "");
  TextEditingController combustibleController = TextEditingController(text: "");
  TextEditingController tanqueController = TextEditingController(text: "");
  TextEditingController trabajadorController = TextEditingController(text: "");
  TextEditingController deptoController = TextEditingController(text: "");
  TextEditingController resguarporController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    if(arguments.isNotEmpty) {
      placaController.text = arguments["placa"] ?? '';
      tipoController.text = arguments["tipo"].toString() ?? '';
      numserieController.text = arguments["numeroserie"] ?? '';
      combustibleController.text = arguments["combustible"] ?? '';
      tanqueController.text = arguments["tanque"].toString() ?? '';
      trabajadorController.text = arguments["trabajador"] ?? '';
      deptoController.text = arguments["depto"] ?? '';
      resguarporController.text = arguments["resguardadopor"] ?? '';
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Actualizar vehiculo"),leading: Icon(Icons.update),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: placaController,
              decoration: const InputDecoration(
                icon: Icon(Icons.abc_rounded),
                hintText: 'Ingresa placa de vehiculo:',
              ),
            ),
            TextField(
              controller: tipoController,
              decoration: const InputDecoration(
                icon: Icon(Icons.commute),
                hintText: 'Ingresa tipo de vehiculo:',
              ),
            ),
            TextField(
              controller: numserieController,
              decoration: const InputDecoration(
                icon: Icon(Icons.abc_rounded),
                hintText: 'Ingresa número de serie:',
              ),
            ),
            TextField(
              controller: combustibleController,
              decoration: const InputDecoration(
                icon: Icon(Icons.ev_station),
                hintText: 'Ingresa que combustible utiliza:',
              ),
            ),
            TextField(
              controller: tanqueController,
              decoration: const InputDecoration(
                icon: Icon(Icons.format_size),
                hintText: 'Ingresa tamaño del tanque:',
              ),
            ),
            TextField(
              controller: trabajadorController,
              decoration: const InputDecoration(
                icon: Icon(Icons.account_box),
                hintText: 'Ingresa nombre trabajador:',
              ),
            ),
            TextField(
              controller: deptoController,
              decoration: const InputDecoration(
                icon: Icon(Icons.help_center),
                hintText: 'Ingresa departamento:',
              ),
            ),
            TextField(
              controller: resguarporController,
              decoration: const InputDecoration(
                icon: Icon(Icons.co_present),
                hintText: 'Resguardado por:',
              ),
            ),
            ElevatedButton(onPressed: () async{
              await actualizarVehiculo(arguments['uid'], int.parse(tanqueController.text), combustibleController.text,
                  deptoController.text, numserieController.text, placaController.text,
                  resguarporController.text, tipoController.text, trabajadorController.text).then((_) {
                Navigator.pop(context);
              });
            }, child: Text("ACTUALIZAR"))
          ],
        ),

      ),
    );
  }
}
