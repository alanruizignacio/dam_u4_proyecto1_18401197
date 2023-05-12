import 'package:dam_u4_proyecto1_18401197/pages/actualizar.dart';
import 'package:dam_u4_proyecto1_18401197/pages/add_name_page.dart';
import 'package:flutter/material.dart';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/inicio.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Inicio(),
      routes: {
        '/add': (context) => const AddNamePage(),
        '/act': (context) => const Actualizar(),
      },
    );
  }
}

