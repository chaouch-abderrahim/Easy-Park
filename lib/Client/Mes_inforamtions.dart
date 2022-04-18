import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MesInformations extends StatefulWidget {
  const MesInformations({Key? key}) : super(key: key);

  @override
  State<MesInformations> createState() => _MesInformationsState();
}

class _MesInformationsState extends State<MesInformations> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Colors.amberAccent,
      appBar: AppBar( backgroundColor: Colors.amber,
        title: const Text("Mes Informations"),),
      body: Column(
        children: const [

        ],
      ),
    );
  }
}
