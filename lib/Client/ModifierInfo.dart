import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String UrlImage="",Nom="",Prenom="",Adress="",Tel="",Email="",Matricule="",url="",cpwd="",pwd="";

  bool ishide=true;
  File? img;
  void deleteFileFromFirebaseByUrl(String urlFile) async {
    print("debut");
    String fileName = urlFile.replaceAll("/o/", "*");
    fileName = fileName.replaceAll("?", "*");
    fileName = fileName.split("*")[1];
    print(fileName.substring(8));
    final storageReferance = FirebaseStorage.instance.ref();
    storageReferance
        .child("image").child("chaouch2022-04-18%2023%3A43%3A34.936139")
        .delete()
        .then((_) => print('Successfully deleted $fileName storage item'));
    print("fin");
  }
  void ModifierInfos() {
    String erreur="";
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

          "Nom": Nom,
          "Prenom": Prenom,
          "Tele": Tel,
          "Adress": Adress,
          "Urlimage":UrlImage

        });
        if(cpwd!=""&& pwd!="" && pwd==cpwd && pwd.length>=8){
          try {
            setState(() {
              erreur="";
            });
            FirebaseAuth.instance.currentUser?.updatePassword(pwd);

          }catch(e){
            print(e);
            setState(() {
              erreur="erreur";
            });
      }

        }

        else{
          String error="";
          if(pwd!=cpwd){
            error="les mot de passe ne sont pas compatible";

          }
          if(pwd.length>=8){
            error=" mot de passe faible au moins 8 carracteres";
          }
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
        }}
      if(erreur==""){
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Email=FirebaseAuth.instance.currentUser!.email!;
    });



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
print(UrlImage);
        });
      }
    }));

  }

  final ImagePicker _picker = ImagePicker();
  Future getImageCamera() async {
    setState(() {
      UrlImage="";
    });
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
    setState(() {
      UrlImage="";
    });
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
                                  image:(UrlImage=="" &&  img==null)? const NetworkImage("https://cdn.pixabay.com/photo/2022/04/02/12/29/wild-daffodils-7106921_640.jpg"): NetworkImage(UrlImage) ,
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
                ]),

              ),
             const SizedBox(height: 30,),
              Padding(padding: const EdgeInsets.only(bottom: 30),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      Nom=value;
                    });
                  },
                  decoration: InputDecoration(

                      contentPadding: const EdgeInsets.only(bottom: 5),
                      labelText: "Nom",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: Nom,
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey

                      )
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(bottom: 30),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      Prenom=value;
                    });
                  },
                  decoration: InputDecoration(

                      contentPadding: const EdgeInsets.only(bottom: 5),
                      labelText: "Prenom",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: Prenom,
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey

                      )
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(bottom: 30),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      Tel=value;
                    });
                  },
                  decoration: InputDecoration(

                      contentPadding: const EdgeInsets.only(bottom: 5),
                      labelText: "Tel",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: Tel,
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey

                      )
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(bottom: 30),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      Adress=value;
                    });
                  },
                  decoration: InputDecoration(

                      contentPadding: const EdgeInsets.only(bottom: 5),
                      labelText: "Adress",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: Adress,
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey

                      )
                  ),
                ),
              ),

              Padding(padding: const EdgeInsets.only(bottom: 30),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      pwd=value;
                    });
                  },
                  obscureText: true ? ishide: false,
                  decoration:  InputDecoration(
                      suffixIcon: true ? IconButton(onPressed: (){setState(() {
                        ishide=!ishide;
                      });}, icon: ishide?const Icon(Icons.visibility_off ,color:Colors.deepOrange):const Icon(Icons.remove_red_eye  ,color:Colors.deepOrange),
                      ):null,
                      contentPadding: EdgeInsets.only(bottom: 5),
                      labelText: "Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "password",
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey

                      )
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(bottom: 30),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      cpwd=value;
                    });
                  },
                  obscureText: true ? ishide: false,
                  decoration:  InputDecoration(
                      suffixIcon: true ? IconButton(onPressed: (){setState(() {
                        ishide=!ishide;
                      });}, icon: ishide?const Icon(Icons.visibility_off ,color:Colors.deepOrange):const Icon(Icons.remove_red_eye  ,color:Colors.deepOrange),
                      ):null,
                      contentPadding: const EdgeInsets.only(bottom: 5),
                      labelText: "Confirme Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Confirme Password",
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey

                      )
                  ),
                ),
              ),

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
                  ElevatedButton(onPressed: () async {
                    print(Nom);

                  if (img != null) {
                      final storageRef = FirebaseStorage.instance.ref();
                      final now = DateTime.now();
                        // Create a reference to "mountains.jpg"
                      final mountainsRef = storageRef.child("image/$Nom"+Matricule);
                      try {
                        await mountainsRef.putFile(img!);
                      } on FirebaseException catch (e) {
                        print(e.message.toString());
                      }

                      url = await mountainsRef.getDownloadURL();
                      setState(() {
                        UrlImage=url;
                      });
                      print (  UrlImage);


                    }
                  ModifierInfos();

                  },
                      child: const Text("Modifier",
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white
                      ),
                      ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrangeAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
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
      onChanged: (value){
        setState(() {
          placeholder=value;
        });
      },
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
