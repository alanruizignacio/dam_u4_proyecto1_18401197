import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto1_18401197/pages/add_bitacora_page.dart';
import 'package:dam_u4_proyecto1_18401197/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Bitacoras extends StatefulWidget {
  final String vehiculoId;

  const Bitacoras({Key? key, required this.vehiculoId}) : super(key: key);

  @override
  State<Bitacoras> createState() => _BitacorasState();
}

class _BitacorasState extends State<Bitacoras> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("bitacora de vehiculo"),),
      body: FutureBuilder<List>(
        future: getBitacoras(widget.vehiculoId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final bitacoraData = snapshot.data?[index];
                return ListTile(
                  title: Text(bitacoraData?['evento'] ?? 'Evento no disponible',),
                  subtitle: Text((bitacoraData?['fecha'] as Timestamp)?.toDate().toString() ?? 'No disponible',),


                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('¿desea acutalizar la bitacora ${snapshot.data?[index]['evento']}?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Actualizar'),
                              onPressed: () async {
                                await Navigator.pushNamed(context, "/actbi",arguments: {
                                  "bitacoraId": snapshot.data?[index]['uid'],
                                  "fechaverificacion":snapshot.data?[index]['fechaverificacion'] as Timestamp,
                                  "verifico":snapshot.data?[index]['verifico'],
                                  "vehiculoId": widget.vehiculoId,
                                });
                                setState(() {const Center(
                                    child: Text("Cargando...")
                                );});
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Cancelar',
                                style: TextStyle(color: Colors.red),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },

                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar las bitácoras'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => AddBitacora(vehiculoId: widget.vehiculoId),
            ),
          );
          setState(() {});
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
