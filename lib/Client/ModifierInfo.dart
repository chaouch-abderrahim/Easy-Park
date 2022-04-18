import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModifierInfos extends StatefulWidget {
  const ModifierInfos({Key? key}) : super(key: key);

  @override
  State<ModifierInfos> createState() => _ModifierInfosState();
}

class _ModifierInfosState extends State<ModifierInfos> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Colors.amberAccent,
      appBar: AppBar( backgroundColor: Colors.amber,
        title: const Text("Modifier Les  Informations"),),
      body: Column(
        children: const [

        ],
      ),
    );
  }
}
