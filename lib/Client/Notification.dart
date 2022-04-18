import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Noti extends StatefulWidget {
  const Noti({Key? key}) : super(key: key);

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Colors.amberAccent,
      appBar: AppBar( backgroundColor: Colors.amber,
      title: const Text("Notification"),),
      body: Column(
        children: const [

        ],
      ),
    );
  }
}
