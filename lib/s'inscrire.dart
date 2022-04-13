import 'package:flutter/material.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  bool v_nom = false;
  bool v_prenom = false;
  bool v_tele = false;
  bool v_matricule = false;
  bool v_adress = false;
  bool _v_email = false;
   late String email='', nom, prenom, matricule, adress, tele;
  Widget Label({required String str, Color? c = Colors.white}) {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        backgroundColor: Colors.amber,
        body: Padding(

          padding:
              const EdgeInsets.only(top: 4, left: 10, right: 10, bottom: 2),
          child: Builder(
            builder: (context) {
              return Column(

                children: [
                  SizedBox(
                    height: 50,
                  ),
                  TextField(
                    onChanged: (value) {
                      nom = value;
                    },
                    cursorColor: Colors.transparent,
                    obscureText: false,
                    style: const TextStyle(color: Colors.brown, fontSize: 20),
                    decoration: InputDecoration(
                      errorText: v_nom ? '* Champ obligatoire' : null,
                      fillColor: Colors.amberAccent,
                      border: InputBorder.none,
                      filled: true,
                      hintText: "Nom",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'PT',
                      ),
                      prefixIcon: Icon(
                        Icons.face,
                        color: Colors.orange,
                        size: 23,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    onChanged: (value) {
                      prenom = value;
                    },
                    cursorColor: Colors.transparent,
                    obscureText: false,
                    style: const TextStyle(color: Colors.brown, fontSize: 20),
                    decoration: InputDecoration(
                      errorText: v_prenom ? '* Champ obligatoire' : null,
                      fillColor: Colors.amberAccent,
                      border: InputBorder.none,
                      filled: true,
                      hintText: "Prenom",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'PT',
                      ),
                      prefixIcon: Icon(
                        Icons.face_outlined,
                        color: Colors.orange,
                        size: 23,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    onChanged: (value) {
                      tele = value;
                    },
                    cursorColor: Colors.transparent,
                    obscureText: false,
                    style: const TextStyle(color: Colors.brown, fontSize: 20),
                    decoration: InputDecoration(
                      errorText: v_tele? '* Champ obligatoire' : null,
                      fillColor: Colors.amberAccent,
                      border: InputBorder.none,
                      filled: true,
                      hintText: "Telephone",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'PT',
                      ),
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: Colors.orange,
                        size: 23,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    onChanged: (value) {
                      adress = value;
                    },
                    cursorColor: Colors.transparent,
                    obscureText: false,
                    style: const TextStyle(color: Colors.brown, fontSize: 20),
                    decoration: InputDecoration(
                      errorText: v_adress ? '* Champ obligatoire' : null,
                      fillColor: Colors.amberAccent,
                      border: InputBorder.none,
                      filled: true,
                      hintText: "Adress",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'PT',
                      ),
                      prefixIcon: Icon(
                        Icons.local_post_office,
                        color: Colors.orange,
                        size: 23,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    onChanged: (value) {
                      matricule = value;
                    },
                    cursorColor: Colors.transparent,
                    obscureText: false,
                    style: const TextStyle(color: Colors.brown, fontSize: 20),
                    decoration: InputDecoration(
                      errorText: v_matricule ? '* Champ obligatoire' : null,
                      fillColor: Colors.amberAccent,
                      border: InputBorder.none,
                      filled: true,
                      hintText: "Matricule",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'PT',
                      ),
                      prefixIcon: Icon(
                        Icons.airport_shuttle,
                        color: Colors.orange,
                        size: 23,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    cursorColor: Colors.transparent,
                    obscureText: false,
                    style: const TextStyle(color: Colors.brown, fontSize: 20),
                    decoration: InputDecoration(
                      errorText: _v_email ? '* Champ obligatoire' : null,
                      fillColor: Colors.amberAccent,
                      border: InputBorder.none,
                      filled: true,
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontFamily: 'PT',
                      ),
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: Colors.orange,
                        size: 23,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {

                      if (email.isEmpty || nom.isEmpty || prenom.isEmpty || tele.isEmpty|| matricule.isEmpty || adress.isEmpty) {
                        print("hello");

                        if (email.isEmpty) {

                          setState(() {
                            _v_email = true;

                          });
                        } else {
                          setState(() {

                            _v_email = false;
                          });
                        }
                        if (nom.isEmpty) {
                          setState(() {
                            v_nom = true;
                            print("email null");
                          });
                        } else {
                          setState(() {
                            v_nom = false;
                            print("email not");
                          });
                        }
                        if (prenom.isEmpty) {
                          setState(() {
                            v_prenom = true;
                          });
                        } else {
                          setState(() {
                            v_prenom = false;
                          });
                        }
                        if (tele.isEmpty) {
                          setState(() {
                            v_tele= true;
                          });
                        } else {
                          setState(() {
                            v_tele = false;
                          });
                        }
                        if (adress.isEmpty) {
                          setState(() {
                            v_adress= true;
                          });
                        } else {
                          setState(() {
                            v_adress = false;
                          });
                        }
                        if (matricule.isEmpty) {
                          setState(() {
                            v_matricule= true;
                          });
                        } else {
                          setState(() {
                            v_matricule = false;
                          });
                        }
                      }


                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(left: 34, right: 34, top: 8, bottom: 8)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange[900]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.red))),
                      side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.grey)),
                    ),
                    child: const Text(
                      'S\'inscrire',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontFamily: 'PT',
                      ),
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
