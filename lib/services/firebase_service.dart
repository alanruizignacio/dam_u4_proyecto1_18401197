import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getVehiculo() async {
  List vehiculo = [];
  //CollectionReference collectionReferenceVehiculo = db.collection('vehiculo');
  QuerySnapshot queryVehiculo = await db.collection('vehiculo').get();
  for(var doc in queryVehiculo.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final car = {
      "combustible": data['combustible'],
      "depto":data['depto'],
      "numeroserie":data['numeroserie'],
      "placa":data['placa'],
      "resguardadopor":data['resguardadopor'],
      "tanque":data['tanque'],
      "tipo":data['tipo'],
      "trabajador":data['trabajador'],
      "uid":doc.id,
    };
    vehiculo.add(car);
  }
  return vehiculo;
}

//Guardar placa en base de datos
Future<void> addVehiculo(int tanque,String combustible, depto,numeroserie,placa,resguardadopor,
    tipo, trabajador) async{
  await db.collection("vehiculo").add({
    "combustible": combustible,
    "depto": depto,
    "numeroserie": numeroserie,
    "placa": placa,
    "resguardadopor": resguardadopor,
    "tanque": tanque,
    "tipo": tipo,
    "trabajador": trabajador
  });


}
//Acutualizar
Future<void> actualizarVehiculo(String uid, int nuevotanque, String nuevocombustible, nuevodepto,
    nuevonumeroserie, nuevoplaca, nuevoresguardadopor, nuevotipo, nuevotrabajador) async{
  await db.collection("vehiculo").doc(uid).set({
    "combustible": nuevocombustible,
    "depto":nuevodepto,
    "numeroserie":nuevonumeroserie,
    "placa":nuevoplaca,
    "resguardadopor":nuevoresguardadopor,
    "tanque":nuevotanque,
    "tipo":nuevotipo,
    "trabajador":nuevotrabajador});
}
//borar
Future<void> borrarVehiculo(String uid) async {
  await db.collection('vehiculo').doc(uid).delete();
}