import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_park/Client/ContactUS.dart';
import 'package:easy_park/Client/payerFacture.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login.dart';
import 'Maps.dart';
import 'Mes_inforamtions.dart';
import 'ModiferAbonnement.dart';
import 'ModifierInfo.dart';
import 'Notification.dart';

class Client extends StatefulWidget {
  const Client({Key? key}) : super(key: key);

  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  final _auth = FirebaseAuth.instance;
  late User signeUser;
  String Debut = "", Fin = "", Prix = "";
  String UrlImage = "";
  String Nom = "";
  String Matricule = "";
  String Email = "";
  String? getcurrentuser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signeUser = user;
      }
    } catch (e) {
      print(e);
    }
    return signeUser.email;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Email = getcurrentuser()!;
    });
    FirebaseFirestore.instance
        .collection('client')
        .get().then((value) => value.docs.forEach((element) {
      if(element.data()["Email"]==Email){
        setState(() {
          Nom=element.data()["Nom"];
          Matricule= element.data()["Matricule"];
          Prix=element.data()["Abonnement"]["Prix"];
          Fin=element.data()["Abonnement"]["Fin"].toDate().toString().substring(0,10);
          Debut = element.data()["Abonnement"]["Debut"].toDate().toString().substring(0,10);
          UrlImage=element.data()["Urlimage"];

        });
      }

      print(Debut);
      print(element.data()["Matricule"]);

    }));

  }

  late String? curUser = getcurrentuser();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                            UrlImage != "" ? NetworkImage(UrlImage) : null,
                            child:UrlImage == "" ? const Image(
                              image: AssetImage("Images/man.png"),
                            ):null,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          " Nom : $Nom",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Nunito",
                              fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          " Email : $Email",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Nunito",
                              fontSize: 14
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text(
                  'Mes Informations',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MesInformations()));
                },
              ),
              ListTile(
                title: const Text(
                  'Modifier Mes  Informations',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ModifierInfos()));
                },
              ),
              ListTile(
                title: const Text(
                  'Modifier Mon abonnement ',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ModifierAbonnement()));
                },
              ),
              ListTile(
                title: const Text(
                  'Payer mes factures',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PayerFacture()));
                },
              ),
              ListTile(
                title: const Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ContactUS()));
                },
              ),
              ListTile(
                title: const Text(
                  'Quitter',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () async {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Acceuil()));
                },
              ),
              ListTile(
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                        icon: const Icon(
                          Icons.chevron_left_rounded,
                          size: 50,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        });
                  },
                ),
                iconColor: Colors.amber,
                onTap: () {
                  // Update the state of the app
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 40,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                  MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            backgroundColor: Colors.amber,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_active_outlined,
                    size: 40,
                  ),
                  tooltip: 'Notification',
                  onPressed: () {
                    // handle the press
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Noti()));
                  },
                ),
                const SizedBox(
                  width: 1,
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage:
                      UrlImage != "" ? NetworkImage(UrlImage) : null,
                      child:UrlImage == "" ? const  Image(
                        image: AssetImage("Images/man.png"),
                      ):null,
                    ),
                    const Positioned(
                      top: 38,
                      left: 70,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
            ]),
        backgroundColor: Colors.amberAccent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView(
              children: [
                Row(
                  children: [
                    Text(
                      "  \tBIENVENU \t $Nom",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontFamily: "PTSans",
                          fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 45,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("Images/user.png"),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Numéro De Matricule \n $Matricule",
                      style: const TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.w900,
                          fontFamily: "PTSans",
                          fontSize: 24),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              " Mon abonnement : ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "PTSans",
                                  fontSize: 24),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.deepOrange,
                                  radius: 42,
                                  child: CircleAvatar(
                                    radius: 36,
                                    backgroundColor: Colors.greenAccent,
                                    child: Text(
                                      "Debut",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: " Nunito",
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Text(
                                  "$Debut",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Nunito",
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  radius: 42,
                                  child: CircleAvatar(
                                    radius: 36,
                                    backgroundColor: Colors.greenAccent,
                                    child: Text(
                                      "Prix",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: " Nunito",
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Text(
                                  "$Prix",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Nunito",
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 42,
                                  child: CircleAvatar(
                                    radius: 36,
                                    backgroundColor: Colors.greenAccent,
                                    child: Text(
                                      "Fin",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Nunito",
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Text(
                                  "$Fin",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Nunito",
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Localisation de la voiture : ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "PTSans",
                                    fontSize: 24),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Center(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>  Maps(Matricule)));
                                    },
                                    icon: const Icon(Icons.local_parking_outlined),
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(10)),
                                    ),
                                    label: const Text(
                                      " Localisation",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "Nunito",
                                          fontSize: 24),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
