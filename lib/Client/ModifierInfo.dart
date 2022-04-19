import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ModifierInfos extends StatefulWidget {
  const ModifierInfos({Key? key}) : super(key: key);

  @override
  State<ModifierInfos> createState() => _ModifierInfosState();
}

class _ModifierInfosState extends State<ModifierInfos> {
  String UrlImage="",Nom="",Prenom="",Adress="",Tel="",Email="",Matricule="";
  String nom="",prenom="",adress="",email="",tele="";
  bool ishide=true;
  File? img;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Email=FirebaseAuth.instance.currentUser!.email!;
    });
    void ModifierInfos() {
      setState(() {
        Email = FirebaseAuth.instance.currentUser!.email!;
      });
      FirebaseFirestore.instance
          .collection("client")
          .get()
          .then((QuerySnapshot snapshot) => snapshot.docs.forEach((element) {
          if (element["Email"]==Email) {
            FirebaseFirestore.instance
                .collection("client")
                .doc(element.id)
                .update({

                "Nom": nom,
                "Prenom": prenom,
                "Tele": tele,
                "Adress": adress,

            });
            AwesomeDialog(
              context: context,
              keyboardAware: true,
              dismissOnBackKeyPress: false,
              dialogType: DialogType.WARNING,
              animType: AnimType.BOTTOMSLIDE,
              btnOkText: "ok",
              title: "Operation passer avec succes ",
              // padding: const EdgeInsets.all(5.0),

              btnOkOnPress: () {},
            ).show();
          } else {
            AwesomeDialog(
              context: context,
              keyboardAware: true,
              dismissOnBackKeyPress: false,
              dialogType: DialogType.WARNING,
              animType: AnimType.BOTTOMSLIDE,
              btnOkText: "ok",
              title: "Erreur dans la modification",
              // padding: const EdgeInsets.all(5.0),

              btnOkOnPress: () {},
            ).show();
          }

      }));
    }

    FirebaseFirestore.instance
        .collection('client')
        .get().then((value) => value.docs.forEach((element) {
      if(element.data()["Email"]==Email){
        setState(() {
          Nom=element.data()["Nom"];
          Matricule= element.data()["Matricule"];
          Prenom=element.data()["Prenom"];
          Tel=element.data()["Tele"];
          Adress = element.data()["Adress"];
          UrlImage=element.data()["Urlimage"];

        });
      }
    }));

  }

  final ImagePicker _picker = ImagePicker();
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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Colors.amberAccent,
      appBar: AppBar( backgroundColor: Colors.amber,
        title: const Text("Modifier Les  Informations"),),
      body: Container(
        padding: const EdgeInsets.only(left: 15,top: 20,right: 15),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child:
                Stack(children: [
                  Container(
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70,
                          child: CircleAvatar(
                            backgroundImage: img != null ? FileImage(img!) : null,
                            radius: 64,
                            child:
                            Container(
                              width: 120,
                              height:130 ,
                              decoration: BoxDecoration(

                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1)
                                  )
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:UrlImage==""? const NetworkImage("https://cdn.pixabay.com/photo/2022/04/02/12/29/wild-daffodils-7106921_640.jpg"): NetworkImage(UrlImage),
                                ),
                              ),
                            ),
                          ))),
                  Positioned(
                      top: 90,
                      left: 70,
                      child: RawMaterialButton(
                        elevation: 10,
                        fillColor: Colors.white,
                        child: const Icon(Icons.edit),
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
                ]),/*Stack(
                  children: [
                    Container(
                      width: 120,
                      height:130 ,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4,color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                         image:UrlImage==""? const NetworkImage("https://cdn.pixabay.com/photo/2022/04/02/12/29/wild-daffodils-7106921_640.jpg"): NetworkImage(UrlImage),
                      ),
                    ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 4,color: Colors.white),
                            color: Colors.green,),

                        ),
                    ),
                  ],
                )*/

              ),
             const SizedBox(height: 30,),
              BuildTextField("Nom",Nom,false),
              BuildTextField("Prenom",Prenom,false),
              BuildTextField("Tel",Tel,false),
              BuildTextField("Adress",Adress,false),
              BuildTextField("Password","password",true),
              BuildTextField("Confirme Password","confirme password",true),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*OutlinedButton(onPressed: (){},
                      child: const Text("Annuler",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black
                      ),)
                      ,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  )*/ElevatedButton(onPressed: (){},
                    child: const Text("Annuler",
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                  ElevatedButton(onPressed: (){},
                      child: const Text("Modifier",
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white
                      ),
                      ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrangeAccent,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      )
    );
  }
  Widget BuildTextField(String labelText,String placeholder ,bool isPwdField){
    return Padding(padding: const EdgeInsets.only(bottom: 30),
    child: TextField(
      obscureText: isPwdField ? ishide: false,
      decoration: InputDecoration(
        suffixIcon: isPwdField ? IconButton(onPressed: (){setState(() {
          ishide=!ishide;
        });}, icon: ishide?const Icon(Icons.visibility_off ,color:Colors.deepOrange):const Icon(Icons.remove_red_eye  ,color:Colors.deepOrange),
        ):null,
        contentPadding: const EdgeInsets.only(bottom: 5),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey

        )
      ),
    ),
    );
  }
}
