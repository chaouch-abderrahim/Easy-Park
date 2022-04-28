import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Client/Client.dart';
import 'Client/Maps.dart';
import 'Controleur.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _auth==null?const SplachScreen():_auth!.email=="controleur"? const Control():const Client()
      ),
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
          MaterialPageRoute(builder: (context) => const Acceuil())),

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

