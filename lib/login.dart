
import 'package:easy_park/Abonnement.dart';
import 'package:easy_park/s\'inscrire.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'Client/Client.dart';
import 'Controleur.dart';
import 'forgetpassword.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({Key? key}) : super(key: key);

  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  final _auth = FirebaseAuth.instance;
  String email="";
  String password="";
  bool spin = false;
  bool etat = false;
  bool _validatepassword = false;
  bool _validatemail = false;
  bool visible=true;

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 100, bottom: 30),
          child: Text(
            'Bienvenu chez Easy Park',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 28, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget label({required String str, Color? c = Colors.white}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Text(
            str,
            style:
            TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: c),
          ),
        ),
      ],
    );
  }

  Widget _button() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          spin=true;
        });
        if(email==""){
          setState(() {
            _validatemail=true;
          });
        }
        else{
          setState(() {
            _validatemail=false;

          });
        }

        if(password==""){
          setState(() {
            _validatepassword=true;
          });
        }
        else{
          setState(() {
            _validatepassword=false;
          });
        }
        if(_validatepassword==false && _validatemail==false){
          try {

            await _auth.signInWithEmailAndPassword(
                email: email, password: password).then((value)=>{
            setState(() {
            spin=false;
            }),
              if (email.compareTo("controleur@gmail.com") == 0 &&
                  password.compareTo("controleur") == 0) {

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Control()))
              } else {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const Client()))
              }
            });
            setState(() {
              etat=false;
              spin=false;
            });

          } catch (e) {
            print("bonjour   $e");
            setState(() {
              etat=true;
              spin=false;
            });

          }}else{
          setState(() {
            spin=false;
          });
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        side: MaterialStateProperty.all(const BorderSide(color: Colors.grey)),
      ),
      child: const Text(
        'Se connecter',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontFamily: 'PT',
        ),
      ),
    );
  }

  Widget _passwordOublier() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>const Abonnement()));
            },
            child: const Text(
              'S\'inscrire',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'PT',
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetScreen()));
            },
            child: const Text(
              'Mot de passe oublier ?',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'PT',
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
@override
  void dispose() {
    // TODO: implement dispose
  setState(() {
    spin=false;
  });
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      spin=false;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.amber,
          resizeToAvoidBottomInset: false,
          body: ModalProgressHUD(
            inAsyncCall: spin,
            child: Column(
                children: [
                  title(),
                  label(str: 'Email :'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      onChanged: (value) {
                        email = value.trim();
                      },
                      cursorColor: Colors.transparent,
                      obscureText: false,
                      style: const TextStyle(color: Colors.brown, fontSize: 20),
                      decoration: InputDecoration(
                        errorText: _validatemail ? 'Value Can\'t Be Empty' : null,
                        fillColor: Colors.amberAccent,
                        border: InputBorder.none,
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
                    ),
                  ),

                  label(str: 'Password :'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        password = value.trim();
                      },
                      cursorColor: Colors.transparent,
                      obscureText: visible,
                      style: const TextStyle(color: Colors.brown, fontSize: 20),
                      decoration: InputDecoration(
                        errorText: _validatepassword ? 'Value Can\'t Be Empty' : null,
                        fillColor: Colors.amberAccent,
                        border: InputBorder.none,
                        filled: true,
                        hintText: 'pasword',
                        hintStyle: const TextStyle(

                          color: Colors.black,

                        ),
                        suffixIcon: visible
                            ? IconButton(
                            onPressed: () {
                              setState(() {
                                visible = false;
                              });
                            },
                            icon: const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.deepOrange,
                            ))
                            : IconButton(
                            onPressed: () {
                              setState(() {
                                visible = true;
                              });
                            },
                            icon: const Icon(
                              Icons.visibility,
                              color: Colors.deepOrange,
                            )),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.orange,
                          size: 23,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 32,
                  ),
                  Visibility(
                    visible: etat,
                    child: Text("password ou Email erreur",style: TextStyle(
                        color: Colors.red[900]
                    ),),
                  ),
                  _passwordOublier(), //textField(bl:true, st:'email',i: Icon(Icons.email_outlined) ),
                  _button(),
                ]),
          ),
        ));
  }
}
