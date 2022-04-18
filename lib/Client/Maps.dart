import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Colors.amberAccent,
      appBar: AppBar( backgroundColor: Colors.amber,
        title: const Text("Localisation"),),
      body: Column(
        children: const [

        ],
      ),
    );
  }
}
