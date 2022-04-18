
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PayNewAbonnement.dart';

class ModifierAbonnement extends StatefulWidget {
  const ModifierAbonnement({Key? key}) : super(key: key);

  @override
  State<ModifierAbonnement> createState() => _ModifierAbonnementState();
}

class _ModifierAbonnementState extends State<ModifierAbonnement> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: const Text("Abonnement"),
          backgroundColor: Colors.amber.withOpacity(1),

        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

                children: [

                  const SizedBox(height: 15,),
                  const Text("choisir un abonnement :",style:  TextStyle(fontSize: 24,fontWeight: FontWeight.w500,),),
                  const SizedBox(height: 30,),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Abonnement").snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasError) return Center(child: Text(snapshot.error.toString()));
                        if(!snapshot.hasData)  return const Center(child:  CircularProgressIndicator());
                        QuerySnapshot data = snapshot.requireData as QuerySnapshot;
                        return Expanded(child: ListView.builder(
                            itemCount: data.size,
                            itemBuilder: (context , index ){
                              Map item = data.docs[index].data() as Map;
                              return ElevatedButton(
                                style:  ButtonStyle(
                                  padding: MaterialStateProperty.all(const EdgeInsets.all(9)),
                                  backgroundColor: MaterialStateProperty.all( Colors.red),
                                ),
                                onPressed: () {
                                  int prix =item["Prix"];
                                  int d =item["Duration"];
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) =>  PayNewAbonnement( d,prix),
                                  )
                                  );
                                },
                                child:  Text(item["Prix"].toString()+' DH Pour '+item["Duration"].toString()+'jours de Parking',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500,),)
                                ,
                              );
                            }
                        ));
                      })


                ]),

          ),
        ),
      ),
    );

  }

}
/*
ElevatedButton(
style:  ButtonStyle(
padding: MaterialStateProperty.all(const EdgeInsets.all(9)),
backgroundColor: MaterialStateProperty.all( Colors.black),
),
onPressed: () {

},
child: const Text('ElevatedButton with custom foreground',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500,),)
,
);*/