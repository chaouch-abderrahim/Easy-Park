import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final controller = TextEditingController();
  final controllerP = TextEditingController();
  final controllerT = TextEditingController();
  final controllerM = TextEditingController();
  final controllerE = TextEditingController();
  final controllerPwd = TextEditingController();
  final controllerA = TextEditingController();
  String nom = "",prenom="",tele="",email="",password="",matricule="",adress="";
  bool valideNom = false,validePrenom=false,valideTele=false,valideAdress=false,valideEmaill=false,valideMatricule=false,validePassword=false,visible=false;
  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
    controllerP.addListener(() => setState(() {}));
    controllerA.addListener(() => setState(() {}));
    controllerM.addListener(() => setState(() {}));
    controllerT.addListener(() => setState(() {}));
    controllerPwd.addListener(() => setState(() {}));
    controllerE.addListener(() => setState(() {}));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Inscription "),
          backgroundColor: Colors.amber,
        ),
        body: ListView(
          children: [
            Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      nom = value;
                    });
                  },
                  controller: controller,
                  scrollPadding: const EdgeInsets.all(22),
                  obscureText: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.amberAccent,
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orangeAccent, width: 2.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orange, width: 2.0)),
                    labelText: "Nom",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.face,
                      color: Colors.orange,
                    ),
                    suffixIcon: controller.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () {
                              controller.clear();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.deepOrange,
                            )),
                    errorText: valideNom ? "le champs est obligatoire *" : null,
                  ),
                ),
              )
            ]),
            Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      prenom = value;
                    });
                  },
                  controller: controllerP,
                  scrollPadding: const EdgeInsets.all(22),
                  obscureText: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.amberAccent,
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orangeAccent, width: 2.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orange, width: 2.0)),
                    labelText: "Prenom",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.mood_sharp,
                      color: Colors.orange,
                    ),
                    suffixIcon: controllerP.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () {
                              controllerP.clear();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.deepOrange,
                            )),
                    errorText: validePrenom ? "le champs est obligatoire *" : null,
                  ),
                ),
              )
            ]),
            Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      tele = value;
                    });
                  },
                  controller: controllerT,
                  scrollPadding: const EdgeInsets.all(22),
                  obscureText: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.amberAccent,
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orangeAccent, width: 2.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orange, width: 2.0)),
                    labelText: "Tel",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.phone_android,
                      color: Colors.orange,
                    ),
                    suffixIcon: controllerT.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () {
                              controllerT.clear();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.pink,
                            )),
                    errorText: valideTele ? "le champs est obligatoire *" : null,
                  ),
                ),
              )
            ]),
            Column(children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      adress = value;
                    });
                  },
                  controller: controllerA,
                  scrollPadding: const EdgeInsets.all(22),
                  obscureText: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.amberAccent,
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.orangeAccent, width: 2.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.orange, width: 2.0)),
                    labelText: "Tel",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.orange,
                    ),
                    suffixIcon: controllerA.text.isEmpty
                        ? Container(
                      width: 0,
                    )
                        : IconButton(
                        onPressed: () {
                          controllerA.clear();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.pink,
                        )),
                    errorText: valideAdress ? "le champs est obligatoire *" : null,
                  ),
                ),
              )
            ]),
            Column(children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      matricule = value;
                    });
                  },
                  controller: controllerM,
                  scrollPadding: const EdgeInsets.all(22),
                  obscureText: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.amberAccent,
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.orangeAccent, width: 2.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.orange, width: 2.0)),
                    labelText: "Matricule",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.king_bed_outlined,
                      color: Colors.orange,
                    ),
                    suffixIcon: controllerM.text.isEmpty
                        ? Container(
                      width: 0,
                    )
                        : IconButton(
                        onPressed: () {
                          controllerM.clear();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.deepOrange,
                        )),
                    errorText: valideMatricule ? "le champs est obligatoire *" : null,
                  ),
                ),
              )
            ]),
            Column(children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  controller: controllerE,
                  scrollPadding: const EdgeInsets.all(22),
                  obscureText: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.amberAccent,
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.orangeAccent, width: 2.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.orange, width: 2.0)),
                    labelText: "Email",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.alternate_email,
                      color: Colors.orange,
                    ),
                    suffixIcon: controllerE.text.isEmpty
                        ? Container(
                      width: 0,
                    )
                        : IconButton(
                        onPressed: () {
                          controllerE.clear();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.deepOrange,
                        )),
                    errorText: valideEmaill ? "le champs est obligatoire *" : null,
                  ),
                ),
              )
            ]),
            Column(children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  controller: controllerPwd,
                  scrollPadding: const EdgeInsets.all(22),
                  obscureText: visible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.amberAccent,
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.orangeAccent, width: 2.0)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.orange, width: 2.0)),
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(
                      Icons.face,
                      color: Colors.orange,
                    ),
                    suffixIcon: visible
                        ? IconButton(
                    onPressed: () {
  setState(() {
    visible=false;
  });
    },
    icon: const Icon(
    Icons.visibility_off_outlined,
    color: Colors.deepOrange,
    ))
                        : IconButton(
                        onPressed: () {
                          setState(() {
                            visible=true;
                          });
                        },
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.deepOrange,
                        )),
                    errorText: validePassword ? "le champs est obligatoire *" : null,
                  ),
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    " valider",
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(10)),
                      backgroundColor: MaterialStateProperty.all(Colors.red[900]),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ))))
            ]),
            const SizedBox(height: 200,)
          ],
        ),
      ),
    );
  }
}
