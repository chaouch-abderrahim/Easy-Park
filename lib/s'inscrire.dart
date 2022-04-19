import 'dart:async';

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'Client/Client.dart';
//import 'package:path/path.dart' as p;

class Inscription extends StatefulWidget {
  int dure = 0;
  String prix="";
  Inscription(int b, String prix, {Key? key}) : super(key: key) {
    this.dure = b;
    this.prix=prix;
  }

  @override
  State<Inscription> createState() => _InscriptionState(dure,prix);
}

class _InscriptionState extends State<Inscription> {
 bool islaoding=false;
  final controller = TextEditingController();
  final controllerP = TextEditingController();
  final controllerT = TextEditingController();
  final controllerM = TextEditingController();
  final controllerE = TextEditingController();
  final controllerPwd = TextEditingController();
  final controllerA = TextEditingController();
  String erreurAuth = "";
  String erreurEmail = "le champs est obligatoire",
      erreurNom = "le champs est obligatoire",
      erreurPrenom = "le champs est obligatoire",
      erreurMatricule = "le champs est obligatoire",
      erreurAdress = "le champs est obligatoire",
      erreurPassword = "le champs est obligatoire";
  String erreurTel = "le champs est obligatoire";
  String nom = "",
      prenom = "",
      tele = "",
      email = "",
      password = "",
      matricule = "",
      adress = "";
  bool valideNom = false,
      validePrenom = false,
      valideTele = false,
      valideAdress = false,
      valideEmaill = false,
      valideMatricule = false,
      validePassword = false,
      visible = false;
  String url="",UrlImage="";

  Timer? _timer;
  File? img;
  final ImagePicker _picker = ImagePicker();
  int dure = 0;
  String prix="";
  _InscriptionState(int b, String prix) {
    dure = b;
    this.prix=prix;

  }

  Future getImageCamera() async {
    final photo = await _picker.pickImage(source: (ImageSource.camera));
    if (photo != null) {
      setState(() {
        img = File(photo.path);
        print("ok");
      });
    } else {
      print("non image");
    }
  }

  Future getImageGallery() async {
    final photo = await _picker.pickImage(source: (ImageSource.gallery));
    if (photo != null) {
      setState(() {
        img = File(photo.path);
        print("ok");
      });
    } else {
      print("non image");
    }
  }

  Future putImage() async {
    //String name = p.basename(img!.path);
    final storageRef = FirebaseStorage.instance.ref();
    final now = DateTime.now();
// Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child("image/$nom"+now.toString());
    try {
      await mountainsRef.putFile(img!);
    } on FirebaseException catch (e) {
      print(e.message.toString());
    }

      url = await mountainsRef.getDownloadURL();
 setState(() {
   UrlImage=url;
   print("$UrlImage");
 });

    print (url);
  }

  @override
  void initState() {
    setState(() {
      islaoding=false;
    });
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
  void dispose() {
    // TODO: implement dispose
//_timer!.cancel();
setState(() {
  islaoding=false;
});
    super.dispose();
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
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Stack(children: [
                Container(
                    child: CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        radius: 70,
                        child: CircleAvatar(
                          backgroundImage: img != null ? FileImage(img!) : null,
                          radius: 64,
                          child: img == null
                              ? const Image(
                                  image: AssetImage("Images/man.png"),
                                )
                              : null,
                        ))),
                Positioned(
                    top: 90,
                    left: 70,
                    child: RawMaterialButton(
                      elevation: 10,
                      fillColor: Colors.deepOrange,
                      child: const Icon(Icons.add_a_photo),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  "Selection un option :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.deepOrange),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(children: [
                                    InkWell(
                                      onTap: () {
                                        getImageCamera();
                                      },
                                      splashColor: Colors.orange,
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.camera,
                                              color: Colors.deepOrange,
                                            ),
                                          ),
                                          Text("Camera",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "PT")),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        getImageGallery();
                                      },
                                      splashColor: Colors.orange,
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.image,
                                                color: Colors.deepOrange),
                                          ),
                                          Text("Gallery",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "PT")),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            img = null;
                                          });
                                        },
                                        splashColor: Colors.deepOrange,
                                        child: Row(
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.remove_circle,
                                                  color: Colors.deepOrange),
                                            ),
                                            Text("Supprimer",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "PT",
                                                  color: Colors.red,
                                                )),
                                          ],
                                        )),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context, true);
                                        },
                                        splashColor: Colors.deepOrange,
                                        child: Row(
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.close,
                                                  color: Colors.red),
                                            ),
                                            Text("Fermer",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "PT",
                                                  color: Colors.red,
                                                )),
                                          ],
                                        ))
                                  ]),
                                ),
                              );
                            });
                      },
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                    ))
              ]),
            ),
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
                              nom="";
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.deepOrange,
                            )),
                    errorText: valideNom ? erreurNom : null,
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
                              prenom="";
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.deepOrange,
                            )),
                    errorText: validePrenom ? erreurPrenom : null,
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
                              tele="";
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.pink,
                            )),
                    errorText: valideTele ? erreurTel : null,
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
                    labelText: "Adresse",
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
                              adress="";
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.pink,
                            )),
                    errorText: valideAdress ? erreurAdress : null,
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
                              matricule="";
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.deepOrange,
                            )),
                    errorText: valideMatricule ? erreurMatricule : null,
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
                              email="";
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.deepOrange,
                            )),
                    errorText: valideEmaill ? erreurEmail : null,
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
                      Icons.password,
                      color: Colors.orange,
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
                    errorText: validePassword ? erreurPassword : null,
                  ),
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed:islaoding ? null: () async {
                    setState(() {
                      islaoding=true;
                    });

                    if (nom == "") {
                      setState(() {
                        valideNom = true;
                      });
                    } else {
                      setState(() {
                        valideNom = false;
                      });
                    }
                    if (prenom == "") {
                      print(prenom+"ddddd");
                      setState(() {
                        validePrenom = true;
                      });
                    } else {
                      print(prenom);
                      setState(() {
                        validePrenom = false;
                      });
                    }
                    if (tele == "") {
                      setState(() {
                        valideTele = true;
                      });
                    } else {
                      setState(() {
                        valideTele = false;
                      });
                    }
                    if (adress == "") {
                      setState(() {
                        valideAdress = true;
                      });
                    } else {
                      setState(() {
                        valideAdress = false;
                      });
                    }
                    if (matricule == "") {
                      setState(() {
                        valideMatricule = true;
                      });
                    } else {
                      setState(() {
                        valideMatricule = false;
                      });
                    }
                    if (email == "" || email.contains("@") == false) {
                      setState(() {
                        valideEmaill = true;
                      });
                      if (email.contains("@") == false) {
                        setState(() {
                          erreurEmail = " Un email  doit etre contient @";
                        });
                      }
                    } else {
                      setState(() {
                        valideEmaill = false;
                      });
                    }
                    if (password == "" || password.length < 8) {
                      setState(() {
                        validePassword = true;
                      });
                      if (password.length < 8) {
                        setState(() {
                          erreurPassword =
                              " Il doit être composé d'au moins 8 caractères";
                        });
                      }
                    } else {
                      setState(() {
                        validePassword = false;
                      });
                    }

                    if (!validePrenom &&
                        !validePassword &&
                        !valideEmaill &&
                        !valideMatricule &&
                        !valideTele &&
                        !valideNom &&
                        !valideAdress) {


                      try {
                        UserCredential  userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        setState(() {
                          erreurAuth="";
                        });
                       /*User? user=  FirebaseAuth.instance.currentUser;
                        if(user?.emailVerified==false){
                          setState(() {
                            erreurAuth="virfier votre email";
                          });
                          user?.sendEmailVerification();
                          _timer=Timer.periodic(const Duration(seconds: 2), (timer) async {

                                await  user!.reload();
                            if (user.emailVerified) {
                              setState(() {
                                erreurAuth="";
                              });
                              print('Cancel timer');
                              timer.cancel();
                            }
                          });

                        }*/
                       print(FirebaseAuth.instance.currentUser?.email.toString()) ;
                      //checkEmail(userCredential.user as User );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          setState(() {
                            erreurAuth = "eak-password";
                          });
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          setState(() {
                            erreurAuth =
                                " Le compte existe déjà pour cet e-mail";
                          });
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        setState(() {
                          erreurAuth = " operation-not-allowed";
                        });
                        print(e);
                      }
                      FirebaseFirestore.instance
                          .collection('client')
                          .get()
                          .then((QuerySnapshot querySnapshot) {
                        querySnapshot.docs.forEach((doc) {
                          if( doc["Matricule"]==matricule){
                            erreurAuth="cette Matricule existe deja ";
                          }
                        });
                      });

                      if (erreurAuth == "") {
                        if (img != null) {
                          final storageRef = FirebaseStorage.instance.ref();
                          final now = DateTime.now();
// Create a reference to "mountains.jpg"
                          final mountainsRef = storageRef.child("image/$nom"+now.toString());
                          try {
                            await mountainsRef.putFile(img!);
                          } on FirebaseException catch (e) {
                            print(e.message.toString());
                          }

                          url = await mountainsRef.getDownloadURL();
                          setState(() {
                            UrlImage=url;
                            print("$UrlImage");
                          });

                          print (url);

                        }

                        final now = DateTime.now();
                        await   FirebaseFirestore.instance.collection("client").add({
                          "Abonnement":{
                            "Debut":now
                            ,
                            "Fin":now.add(Duration(days: dure)),
                            "Duration":dure,
                            "Prix":prix+"DH"},
                          "Adress":adress,
                          "abdeEmail":email,
                          "Matricule":matricule,
                          "Nom":nom,
                          "Prenom":prenom,
                          "Tele":tele,
                          "Urlimage":UrlImage,

                        });
                        setState(() {
                          islaoding=false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Client()));
                      } else {
                        setState(() {
                          islaoding=false;
                        });
                        AwesomeDialog(
                          context: context,
                          keyboardAware: true,
                          dismissOnBackKeyPress: false,
                          dialogType: DialogType.WARNING,
                          animType: AnimType.BOTTOMSLIDE,
                          btnCancelText: "Annuler",
                          btnOkText: "ok",
                          title: erreurAuth,
                          // padding: const EdgeInsets.all(5.0),
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      }
                    }
                    else{
                      setState(() {
                        islaoding=false;
                      });
                    }
                  },
                  child:islaoding?const CircularProgressIndicator(semanticsLabel: "Please Waite ...",):  const Text(
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
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[900]),
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
            const SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }
  /*Future<void>VedifierEmail(){

  }

  Future <void>checkEmail(User use) async{
    if(use.emailVerified==false){
      print(  use.email);

      setState(() {
        erreurAuth = "Verfier votre Email  verified !";
      });
    use.sendEmailVerification();}
    else{
      setState(() {
        erreurAuth = "";
      });
      return ;
    }

    _timer=Timer.periodic(const Duration(seconds: 2), (timer)async {
      await use.reload();
      if (use.emailVerified == true) {
        setState(() {
          erreurAuth = "";
          _timer?.cancel();
        });

        print("bien verifier");
        return ;
      }
      else {


         await use.reload();



        print(use.emailVerified.toString()+" "+use.email.toString()+"ddddddd");
      }



    });
    return;

  }*/
}
