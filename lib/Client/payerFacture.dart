import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'Client.dart';

class PayerFacture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PayerFactureState();
  }
}

class PayerFactureState extends State<PayerFacture> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String Email = "";
  DateTime date = DateTime.now();
  late Timestamp now = Timestamp.fromDate(date);
  late Timestamp Fin, debut;

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  void payerFacture() {
    setState(() {
      Email = FirebaseAuth.instance.currentUser!.email!;
    });
    FirebaseFirestore.instance
        .collection("client")
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs.forEach((element) {
              if (element["Email"] == Email) {
                /* setState(() {
                  Fin=element["Abonnement"]["Fin"];
                           });*/
                if (now.compareTo(element["Abonnement"]["Fin"]) >= 0) {
                  FirebaseFirestore.instance
                      .collection("client")
                      .doc(element.id)
                      .update({
                    "Abonnement": {
                      "Debut": now,
                      "Fin": date.add(
                          Duration(days: element["Abonnement"]["Duration"])),
                      "Prix": element["Abonnement"]["Prix"],
                      "Duration": element["Abonnement"]["Duration"]
                    }
                  });
                  AwesomeDialog(
                    context: context,
                    keyboardAware: true,
                    dismissOnBackKeyPress: false,
                    dialogType: DialogType.WARNING,
                    animType: AnimType.BOTTOMSLIDE,
                    btnOkText: "ok",
                    title: "Operation passer avec succes Merci",
                    // padding: const EdgeInsets.all(5.0),
                    btnCancelOnPress: () {},
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
                    title: "Vous n'avez  aucune facture",
                    // padding: const EdgeInsets.all(5.0),
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {},
                  ).show();
                }
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payer Facture"),
        backgroundColor: Colors.amber,
      ),
      body: MaterialApp(
        title: 'Flutter Credit Card View Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              image: !useBackgroundImage
                  ? const DecorationImage(
                      image: ExactAssetImage('Images/1.gif'),
                      fit: BoxFit.fill,
                    )
                  : null,
              color: Colors.black,
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  CreditCardWidget(
                    glassmorphismConfig:
                        useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    cardBgColor: Colors.blueAccent,
                    backgroundImage:
                        useBackgroundImage ? 'Images/card.png' : null,
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange:
                        (CreditCardBrand creditCardBrand) {},
                    customCardTypeIcons: <CustomCardTypeIcon>[
                      CustomCardTypeIcon(
                        cardType: CardType.mastercard,
                        cardImage: Image.asset(
                          'Images/mastercard.png',
                          height: 48,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CreditCardForm(
                            formKey: formKey,
                            obscureCvv: true,
                            obscureNumber: true,
                            cardNumber: cardNumber,
                            cvvCode: cvvCode,
                            isHolderNameVisible: true,
                            isCardNumberVisible: true,
                            isExpiryDateVisible: true,
                            cardHolderName: cardHolderName,
                            expiryDate: expiryDate,
                            themeColor: Colors.blue,
                            textColor: Colors.white,
                            cardNumberDecoration: InputDecoration(
                              labelText: 'Number',
                              hintText: 'XXXX XXXX XXXX XXXX',
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: border,
                              enabledBorder: border,
                            ),
                            expiryDateDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'Expired Date',
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'CVV',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'Card Holder',
                            ),
                            onCreditCardModelChange: onCreditCardModelChange,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Glassmorphism',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Switch(
                                value: useGlassMorphism,
                                inactiveTrackColor: Colors.grey,
                                activeColor: Colors.white,
                                activeTrackColor: Colors.green,
                                onChanged: (bool value) => setState(() {
                                  useGlassMorphism = value;
                                }),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Card Image',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Switch(
                                value: useBackgroundImage,
                                inactiveTrackColor: Colors.grey,
                                activeColor: Colors.white,
                                activeTrackColor: Colors.green,
                                onChanged: (bool value) => setState(() {
                                  useBackgroundImage = value;
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              primary: const Color(0xff1b447b),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              child: const Text(
                                'Validate',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'halter',
                                  fontSize: 14,
                                  package: 'flutter_credit_card',
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print('valid!');
                                payerFacture();
                                 Navigator.push((context), MaterialPageRoute(builder: (context)=>const Client()));
                              } else {
                                print('invalid!');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
