import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:switcher_button/switcher_button.dart';
class Maps extends StatefulWidget {
  String matricule="";
  Maps(this.matricule, {Key? key,  }) : super(key: key);

  @override
  State<Maps> createState() => _MapsState(matricule);
}

class _MapsState extends State<Maps> {



  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.8598955, -5.5787963),
    zoom: 14.4746,
  );
  late GoogleMapController _googleMapController;
  Marker _origin=const Marker(markerId:  MarkerId('origin'));
  late Marker _destination=const Marker( markerId:  MarkerId('destination'));

  //position
  Marker position =Marker(
    markerId: const MarkerId('destination'),
    infoWindow: const InfoWindow(title: 'Destination'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    position:LatLng(33.8598955, -5.5787963) ,
  );
  static  const CameraPosition _kLake =   CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(33.8598955, -5.5787963),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  MapType maptype =MapType.none;
  String matricule="";
  LatLng lacalisation =const LatLng( 33.85989,-5.57879 );
  _MapsState(this.matricule);
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState .collection("Parking")
    // .orderBy("Time Entrer", "desc")
    super.initState();
    FirebaseFirestore.instance.collection("Parking").orderBy("Time Entrer", descending: true).limit(1).get()

        .then(
        (value){
          value.docs.forEach((element) {
           if(element.data()["Matricule"]==matricule){
             print(element.data()["lacation"].latitude.toString());
             setState(() {
               lacalisation = LatLng(double. parse(element.data()["lacation"].latitude.toString()),double. parse(element.data()["lacation"].longitude.toString()));
             });
           }

          });
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: Colors.amberAccent,
      appBar: AppBar( backgroundColor: Colors.amber,
        title: const Text("Localisation"),


        actions: [ Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(

            children: [
              const Icon(Icons.satellite,semanticLabel:"satellite" ,color: Colors.deepOrange,),
              SwitcherButton(
                value: true,
                onChange: (value) {
                  print(value);
                  if(value){
                    setState(() {
                      maptype=MapType.normal;
                    });
                  }
                  else{
                    setState(() {
                      maptype=MapType.hybrid;
                    });

                  }

                },
              ),
              const Icon(Icons.map,semanticLabel:"satellite" ,color: Colors.deepOrange,),
            ],
          ),
        ),],
      ),

      body:  GoogleMap(
        mapType: maptype,//hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

        markers: {

          Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position:lacalisation ,
          )

        },
        onLongPress: _addMarker,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the car!'),
        icon: Icon(Icons.card_travel),
      ),
    );
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: lacalisation,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414)));
  }
  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination =  Marker(markerId: MarkerId('destination'),);

        // Reset info
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });


    }
  }
}
