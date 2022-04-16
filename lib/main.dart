import 'dart:async';
import 'package:easy_park/Abonnement.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplachScreen(),
    );
  }
}
class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(milliseconds: 3000),
          ()=>Navigator.push(context,
          MaterialPageRoute(builder: (context) =>const  Abonnement())),//const Acceuil())),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Card(
                child: Image(
                  image: AssetImage('Images/playstore.png'),
                  width: 250,
                  height: 250,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

