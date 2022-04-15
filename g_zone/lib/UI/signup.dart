// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:g_zone/UI/login.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
 final myController = TextEditingController();
  final myController2 = TextEditingController();

  final PassController = TextEditingController();
  final PassController2 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    PassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff192543), Color(0xff3C4861)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Color(0xff192543),
            title: Text("Signup Page"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                //}
                //}
                Get.to(() => LoginScreen());
                //}
                //}
              },
            )),
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode:
                AutovalidateMode.always, //check for validation while typing
            key: formkey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                      child: Container(
                    width: 200,
                    height: 350,
                    child: Image(
                      image: AssetImage('images/Untitled-1-01.png'),
                    ),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                      controller: myController,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'abc@mail.com'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Enter valid email "),
                        EmailValidator(errorText: "Enter valid email "),
                      ])),
                ),
                Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 15),
                child: TextFormField(
                    controller: PassController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password Cant be Empty';
                      }
                      if (value != PassController2.text) {
                        return 'Password has to be the same';
                      }
                      if (value.length < 6) {
                        return 'Password Cant be less than 6 Characters ';
                      }
                    }),
              ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                      controller: PassController2,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Enter secure password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Cant be Empty';
                        }
                        if (value.length < 6) {
                          return 'Password Cant be less than 6 Characters ';
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Color(0xff82F395),
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          //}
                          //}
                          //sends data to the back end
                          //}
                          //}
                        } else {
                          formkey.currentState!.validate();
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xffa7ff54), Color(0xff82F395)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Signup",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}