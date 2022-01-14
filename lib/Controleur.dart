import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber[600],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "Images/playstore.png",
                  height: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Easy Park",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.close_sharp,
                  size: 40,
                ),
                tooltip: 'Close',
                onPressed: () {
                  // handle the press
                },
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          backgroundColor: Colors.amber,
          body: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Column(
                  children: [
                   
                    ElevatedButton.icon(
                      onPressed: (){

                      },
                      icon: Icon(Icons.location_on,size: 40,color: Colors.white,),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)
                              )
                          ),

                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        fixedSize: MaterialStateProperty.all(Size.infinite),
                        
                      ),
                        label: Text("Activer localisation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  color:Colors.white ,

                ),
              ),
                    )
                  ],
                  
                ),
              ),
          ),

        ),
    ) ;
  }
}
