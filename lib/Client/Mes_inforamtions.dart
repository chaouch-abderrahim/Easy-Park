import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MesInformations extends StatefulWidget {
  const MesInformations({Key? key}) : super(key: key);

  @override
  State<MesInformations> createState() => _MesInformationsState();
}

class _MesInformationsState extends State<MesInformations> {
  String UrlImage="",Nom="",Prenom="",Adress="",Tel="",Email="",Matricule="";
  bool ishide=true;
  File? img;
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

       });
     }
   }));

 }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        backgroundColor: Colors.amberAccent,
        appBar: AppBar( backgroundColor: Colors.amber,
          title: const Text("Mes  Informations"),),
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
                Stack(
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
                ),

                ),
                const SizedBox(height: 30,),
                LabelText("Nom",Nom),
                Container(height: 3,
                  width: 200,        color: Colors.white,),
                LabelText("Prenom",Prenom),
                Container(height: 3,
                  width: 200,        color: Colors.white,),
                LabelText("Telephone",Tel),
                Container(height: 3,
                  width: 200,        color: Colors.white,),
                LabelText("Adress",Adress),
                Container(height: 3,
                  width: 100,        color: Colors.white,),

                LabelText("Matricule",Matricule),
                Container(height: 3,
                  width: 100,        color: Colors.white,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15,top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Email   :",  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text(Email,  style: const TextStyle(fontSize: 17),),
                    ],
                  ),
                ),  Container(height: 3,
                  width: 100,        color: Colors.white,),

                const SizedBox(height: 30,),

              ],
            ),
          ),
        )
    );
  }

  Widget LabelText(String lbl ,String contenu){
    return Padding(padding: const EdgeInsets.only(bottom: 15,top: 15),
    child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(lbl+"   :",  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Text(contenu,  style: TextStyle(fontSize: 20),),


      ],
    )
    );
  }

}
