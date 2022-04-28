import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email="";
  String erreur="";
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('réinitialiser le mot de passe'.toUpperCase()),),
      body: Center(
        child: Column(

          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration:  InputDecoration(
                  errorText: erreur!= ""? erreur :null,
                  fillColor: Colors.amberAccent,

                  enabledBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.orangeAccent, width: 2.0)),
                  focusedBorder:  const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.orange, width: 2.0)),
                  filled: true,
                  hintText: 'Email',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.orange,
                    size: 23,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value.trim();
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text(
                      "Reset password".toUpperCase(),
                      style: TextStyle(fontSize: 14)
                  ),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: Colors.red)
                          )
                      )
                  ),
                  onPressed: () {
                    if(_email!=""){
                      setState(() {
                        erreur="";
                      });
                      auth.sendPasswordResetEmail(email: _email);
                      AwesomeDialog(
                        context: context,
                        keyboardAware: true,
                        dismissOnBackKeyPress: false,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.BOTTOMSLIDE,

                        btnOkText: "ok",
                        title: "We sent the email to "+_email +"Check your inbox to activate your account.",
                        // padding: const EdgeInsets.all(5.0),

                        btnOkOnPress: () {},
                      ).show();
                    }else{
                      setState(() {
                        erreur="required *";
                      });
                    }


                  },
                ),
                OutlinedButton(
                  child: Text(
                      "Go Back".toUpperCase(),
                      style: const TextStyle(fontSize: 14,
                          color:Colors.red,
                          fontWeight: FontWeight.w600
                      )
                  ),
                  style: ButtonStyle(

                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: Colors.red,width: 3.0)
                          )
                      )
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )


              ],
            ),

          ],),
      ),
    );
  }
  passe(){
    Navigator.of(context).pop();
  }
}