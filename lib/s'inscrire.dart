import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Controleur.dart';

class Inscription extends StatefulWidget {
int b=0;
   Inscription(int b, {Key? key}) : super(key: key){
     this.b=b;
   }


  @override
  State<Inscription> createState() => _InscriptionState(b);
}

class _InscriptionState extends State<Inscription> {
  final controller = TextEditingController();
  final controllerP = TextEditingController();
  final controllerT = TextEditingController();
  final controllerM = TextEditingController();
  final controllerE = TextEditingController();
  final controllerPwd = TextEditingController();
  final controllerA = TextEditingController();
  String erreurEmail="le champs est obligatoire",erreurNom="le champs est obligatoire",erreurPrenom="le champs est obligatoire",erreurMatricule="le champs est obligatoire",erreurAdress="le champs est obligatoire",erreurPassword="le champs est obligatoire";
 String erreurTel="le champs est obligatoire";
  String nom = "",prenom="",tele="",email="",password="",matricule="",adress="";
  bool valideNom = false,validePrenom=false,valideTele=false,valideAdress=false,valideEmaill=false,valideMatricule=false,validePassword=false,visible=false;
  File?  img ;
  final ImagePicker _picker = ImagePicker();
int a=0;
  _InscriptionState(int b){
    a=b;
  }

  Future getImageCamera()async {
    final  photo = await _picker.pickImage(source: (ImageSource.camera));
    if(photo!=null) {

      setState(()  {
      img= File(photo.path);
      print("ok");
    });
    }
    else{
      print("non image");
    }

  }
  Future getImageGallery()async {
    final  photo = await _picker.pickImage(source: (ImageSource.gallery));
    if(photo!=null) {
      setState(()  {
        img= File(photo.path);
        print("ok");
      });
    }
    else{
      print("non image");
    }

  }
  @override
  void initState() {
    print(a);
    print("$a ddf");
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
            const SizedBox(height: 40,),
            Center(
              child: Stack(

                  children: [
                    Container(
                   child: CircleAvatar(
                      backgroundColor: Colors.deepOrange,

                      radius: 70,
                      child: CircleAvatar(
                       backgroundImage: img != null? FileImage(img!) : null,
                        radius: 64,
                        child: img == null?  const Image(image:  AssetImage("Images/man.png"),):null,

                      )
                    )
                    ),
                    Positioned(
                        top:90,
                        left:70,
                        child:RawMaterialButton(
                      elevation:10,
                      fillColor :Colors.deepOrange,
                      child: const Icon(Icons.add_a_photo),
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext context){
                          return  AlertDialog(
                            title:const Text("Selection un option :",style:  TextStyle(fontWeight: FontWeight.w600,color:Colors.deepOrange),) ,
                             content: SingleChildScrollView(
                               child: ListBody(
                                  children: [
                          InkWell(
                            onTap: () {
                              getImageCamera();

                            },
                            splashColor: Colors.orange,
                            child: Row(children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.camera,color: Colors.deepOrange,),
                              ),
                              Text("Camera",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "PT")),
                            ],),

                            ),
                                    InkWell(
                                      onTap: (){
                                        getImageGallery();
                                      },
                                      splashColor: Colors.orange,
                                      child: Row(children: const [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.image,color:Colors.deepOrange),
                                        ),
                                        Text("Gallery",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "PT")),

                                      ],),

                                    ),
                                    InkWell(
                                        onTap:(){
                                          setState(() {
                                            img=null;
                                          });
                                        },
                                        splashColor: Colors.deepOrange,
                                        child :Row(
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.remove_circle,color:Colors.deepOrange),
                                            ),
                                            Text("Supprimer",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "PT",color: Colors.red,)),

                                          ],
                                        )
                                    ),
                                    InkWell(
                                      onTap:(){
                                        Navigator.pop(context, true);
                                      },
                                      splashColor: Colors.deepOrange,
                                      child :Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.close,color:Colors.red),
                                          ),
                                          Text("Fermer",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "PT",color: Colors.red,)),

                                        ],
                                      )
                                    )
                                 ]),
                             ),
                          );
                        });
                      },
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                    ) )

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
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.deepOrange,
                        )),
                    errorText: valideMatricule ? erreurMatricule: null,
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
                    errorText: validePassword ? erreurPassword : null,
                  ),
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () {
                    if(nom==""){
                      setState(() {
                        valideNom=true;
                      });
                    }else{ setState(() {
                      valideNom=false;
                    });}
                    if(prenom==""){
                      setState(() {
                        validePrenom=true;
                      });
                    }else{ setState(() {
                      validePrenom=false;
                    });}
                    if(tele==""){
                      setState(() {
                        valideTele=true;
                      });
                    }else{ setState(() {
                      valideTele=false;
                    });}
                    if(adress==""){
                      setState(() {
                        valideAdress=true;
                      });
                    }else{ setState(() {
                      valideAdress=false;
                    });}
                    if(matricule==""){
                      setState(() {
                        valideMatricule=true;
                      });
                    }else{ setState(() {
                      valideMatricule=false;
                    });}
                    if(email=="" || email.contains("@")==false){
                      setState(() {
                        valideEmaill=true;
                      });
                      if(email.contains("@")==false) {
                        setState(() {erreurEmail=" Un email  doit etre contient @" ;
                        });
                      }
                    }else{ setState(() {
                      valideEmaill=false;
                    });}
                    if(password=="" || password.length<8 ){
                      setState(() {
                        validePassword=true;
                      });
                      if(password.length<8) {
                        setState(() {erreurPassword=" Il doit être composé d'au moins 8 caractères" ;
                        });
                      }

                    }else{ setState(() {
                      validePassword=false;
                    });}
                    if(!validePrenom && !validePassword && !valideEmaill && !valideMatricule && !valideTele && !valideNom && !valideAdress){
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => const Control()));
                    }
                  },
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
