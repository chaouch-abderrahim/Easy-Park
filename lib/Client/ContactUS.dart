import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart'as http;
class ContactUS extends StatefulWidget {
  const ContactUS({Key? key}) : super(key: key);

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5fd),

      appBar: AppBar( backgroundColor: Colors.amber,
        title: const Text("Mes  Informations"),),
      body: Center(
        child: Container(
          height: 450,
          width: 400,
          margin: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 1,
                    color: Colors.grey[300]!)
              ]),
          child: Form(
            key: _formKey,
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Contact Us',
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Required*';
                    } else if (!EmailValidator.validate(email)) {
                      return 'Please enter a valid Email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: messageController,
                  decoration: const InputDecoration(hintText: 'Message'),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 45,
                  width: 110,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: const Color(0xff151534),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await sendEmail(
                              nameController.value.text,
                              emailController.value.text,
                              messageController.value.text);

                          ScaffoldMessenger.of(context).showSnackBar(
                            response == 200
                                ? const SnackBar(
                                content: Text('Message Sent!'),
                                backgroundColor: Colors.green)
                                :  SnackBar(
                                content: Text('Failed to send message!'+nameController.value.text),
                                backgroundColor: Colors.red),
                          );
                          nameController.clear();
                          emailController.clear();
                          messageController.clear();
                        }

                    },
                    child: const Text('Send', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future sendEmail(String name, String email, String message) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_q1v2pjs';
    const templateId = 'template_oxlaqcn';
    const userId = '2Jd7HD3p2XHo1LDX1';
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},//This line makes sure it works for all platforms.
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message
          }
        }));
    return response.statusCode;
  }
}
