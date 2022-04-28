import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  double latitude=10000; // Latitude, in degrees
  double longitude=10000;
  String matricule="",dateMatricule="";
  bool textScanning = false;
  String scannedText = "";
  File? img;
  DateTime date = DateTime.now();
  late Timestamp now = Timestamp.fromDate(date);
  bool existeMatricule=false;
  final ImagePicker _picker = ImagePicker();
  getLocation(context) async {
    print("11111111");
    Location location =new Location();
    print("instancier");
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    print("debut");
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {

      _serviceEnabled = await location.requestService();
      print("demande d'activation service");
      if (!_serviceEnabled) {
        print("demande d'activation service refuser");
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {

      _permissionGranted = await location.requestPermission();
      print("demande d'permession service refuser");
      if (_permissionGranted != PermissionStatus.granted) {
        print("demande d'activation permession refuser");
        return;
      }
    }

    _locationData = await location.getLocation();
    print("prendre localisation");

    print( _locationData.longitude!) ;
    print(_locationData.latitude!);
    setState(() {
      latitude=_locationData.latitude!;
      longitude=_locationData.longitude!;
    });


  }
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
              const SizedBox(
                width: 20,
              ),
              const Text(
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
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        backgroundColor: Colors.amber,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:Colors.grey.withOpacity(0.5),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)
                        )
                      ],
                      border: Border.all(color:Colors.black,width: 0),
                    ),

                    child: Text("Latitude :"+latitude.toString()+"\tLongitude :"+longitude.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        color:Colors.black ,

                      ),),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton.icon(
                    onPressed: (){
                      getLocation(context);

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
                    label: const Text("Prendre localisation",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        color:Colors.white ,

                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton.icon(
                    onPressed: (){
                      getImageCamera();
                      // getImageGallery();


                    },
                    icon: const Icon(Icons.document_scanner_outlined,size: 40,color: Colors.white,),
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
                    label: const Text("Scanne Matricule",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        color:Colors.white ,

                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text("Ou",style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),
                ),
                const Center(
                  child: Text("Manuellement",style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: TextField(
                    onChanged: (value)=>setState(() {
                      scannedText=value;
                    }),
                    cursorColor: Colors.white,
                    cursorWidth: 2,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.red,
                      hintText: "saisir le numéro matricule manuellement",
                      labelStyle:TextStyle(   fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        color:Colors.white ,) ,
                      focusColor: Colors.deepOrange,
                      focusedBorder:  OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blueGrey, width: 2.0)),
                      enabledBorder:  OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.orangeAccent, width: 2.0)),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:Colors.grey.withOpacity(0.5),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)
                        )
                      ],
                      border: Border.all(color:Colors.black,width: 0),
                    ),

                    child:  Text("Numéro Matricule :\n"+scannedText,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        color:Colors.black ,

                      ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(onPressed: (){

                    setState(() {
                      existeMatricule=false;
                      dateMatricule="";

                    });
                    print(scannedText);
                    if(scannedText!="" && longitude!=10000 && latitude!=10000){
                      FirebaseFirestore.instance.collection("client").get().then((value) {
                        value.docs.forEach((element) {
                          if(element.data()["Matricule"]==scannedText.trim()){
                            print(element["Abonnement"]["Fin"].toDate());
                            if(now.compareTo(element["Abonnement"]["Fin"]) > 0){
                              print(element["Abonnement"]["Fin"]);
                             setState(() {
                               dateMatricule="Son abonnement est expirer :\nLe "+element["Abonnement"]["Fin"].toDate().toString();
                             });

                            }
                            setState(() {
                              existeMatricule=true;
                              print("TRUE");
                              print(existeMatricule);
                            });
                          }
                        });
                        if(existeMatricule==true && dateMatricule=="") {
                          try{
                            FirebaseFirestore.instance.collection("Parking").add({
                              "Matricule":scannedText,
                              "date Et Heur":Timestamp.now(),
                              "location":GeoPoint(latitude, longitude),

                            });
                            print("Bien ajouter");}
                          catch(e){
                            print("ttttttt"+e.toString());
                          }
                          AwesomeDialog(
                            context: context,
                            keyboardAware: true,
                            dismissOnBackKeyPress: false,
                            dialogType: DialogType.WARNING,
                            animType: AnimType.BOTTOMSLIDE,
                            btnCancelText: "Annuler",
                            btnOkText: "ok",
                            title: "Bien Enregistrer",
                            // padding: const EdgeInsets.all(5.0),
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        }else{
                          AwesomeDialog(
                            context: context,
                            keyboardAware: true,
                            dismissOnBackKeyPress: false,
                            dialogType: DialogType.WARNING,
                            animType: AnimType.BOTTOMSLIDE,
                            btnCancelText: "Annuler",
                            btnOkText: "ok",
                            title: existeMatricule==false?"Ce personne n'existe pas":dateMatricule,
                            // padding: const EdgeInsets.all(5.0),
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        }
                      }
                      );



                    }else{
                      AwesomeDialog(
                        context: context,
                        keyboardAware: true,
                        dismissOnBackKeyPress: false,
                        dialogType: DialogType.WARNING,
                        animType: AnimType.BOTTOMSLIDE,
                        btnCancelText: "Annuler",
                        btnOkText: "ok",
                        title: "Entrer enrgestrer la localisation et le matricule",
                        // padding: const EdgeInsets.all(5.0),
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      ).show();
                      print("      "+scannedText);
                      print(longitude+latitude);
                      print("dbb");

                    }
                  },
                    child: const Text("Enregistrer",
                      style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 2,
                          color: Colors.white
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                ),

              ],

            ),
          ),
        ),

      ),
    ) ;
  }
  void getRecognisedText(File image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    final  recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        setState(() {
          scannedText = scannedText + line.text + "\n";
        });
      }
    }


  }

  Future getImageCamera() async {

    final photo = await _picker.pickImage(source: (ImageSource.camera));
    if (photo != null) {
      setState(() {
        img = File(photo.path);
        print("ok");
      });
      if(img!=null) {
        print("non image"+img!.path);
       File? croppedFile = await ImageCropper().cropImage(
            sourcePath: img!.path,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
            androidUiSettings: const AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            iosUiSettings: const IOSUiSettings(
              minimumAspectRatio: 1.0,
            )
        );
        getRecognisedText(croppedFile!);
      }
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
        print("non image"+img!.path);
      });

    } else {
      print("non image");
    }
  }
}
