import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class clients extends StatefulWidget {
  const clients({Key? key}) : super(key: key);

  @override
  _clientsState createState() => _clientsState();
}

class _clientsState extends State<clients> {
  final _auth = FirebaseAuth.instance;

  late User signeUser;
  String? getcurrentuser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signeUser = user;
      }
    } catch (e) {
      print(e);
    }
    return signeUser.email;
  }

  late String? curUser = getcurrentuser();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "Images/playstore.png",
                height: 40,
              ),
              SizedBox(
                width: 80,
              ),
              Text(
                "Easy Park",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close_sharp,
                size: 40,
              ),
              tooltip: 'Close',
              onPressed: () {
                // handle the press
              },
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        backgroundColor: Colors.amberAccent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "$curUser",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontFamily: "PTSans",
                    fontSize: 35
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
