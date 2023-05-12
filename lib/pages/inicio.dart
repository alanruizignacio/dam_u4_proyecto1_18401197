import 'package:dam_u4_proyecto1_18401197/services/firebase_service.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Vehículos"),
        ),
        body: FutureBuilder(

            future: getVehiculo(),
            builder: ((context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index){
                    return ListTile(
                        trailing: const Text("Numero de serie", style: TextStyle(fontWeight: FontWeight.bold),),
                        leading: Icon(Icons.directions_car_filled_outlined, size: 40, color: Colors.black87,),
                        title: Text(snapshot.data?[index]['numeroserie'] ?? 'No disponible', style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            'trabajador: ${snapshot.data?[index]['trabajador'] ?? 'No disponible'} \n'
                            'placa: ${snapshot.data?[index]['placa'] ?? 'No disponible'} \n'
                            'Tipo: ${snapshot.data?[index]['tipo'] ?? 'No disponible'} \n'
                                'depto: ${snapshot.data?[index]['depto'] ?? 'No disponible'} \n'
                          ),

                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('¿Qué desea hacer con el vehículo ${snapshot.data?[index]['numeroserie']}?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Actualizar'),
                                  onPressed: () async {
                                    await Navigator.pushNamed(context, "/act",arguments: {
                                      "uid": snapshot.data?[index]['uid'],
                                      "tanque":snapshot.data?[index]['tanque'],
                                      "combustible":snapshot.data?[index]['combustible'],
                                      "depto":snapshot.data?[index]['depto'],
                                      "numeroserie":snapshot.data?[index]['numeroserie'],
                                      "placa":snapshot.data?[index]['placa'],
                                      "resguardadopor":snapshot.data?[index]['resguardadopor'],
                                      "tipo":snapshot.data?[index]['tipo'],
                                      "trabajador":snapshot.data?[index]['trabajador'],
                                    });
                                    setState(() {const Center(
                                      child: Text("Cargando...")
                                    );});
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Eliminar vehiculo'),
                                  onPressed: () async{
                                    await borrarVehiculo(snapshot.data?[index]['uid']);
                                    setState(() {const Center(
                                      child: CircularProgressIndicator(),
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
              } else{
                return const Center(
                  child: Text("Cargando...")
                );
              }
            })),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
             await Navigator.pushNamed(context, '/add');
             setState(() {

             });
            },
            child: const Icon(Icons.add)
          ),
    );
  }
}
