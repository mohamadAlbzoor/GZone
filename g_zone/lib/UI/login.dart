// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:g_zone/UI/home.dart';
import 'package:g_zone/UI/services/user_service.dart';
import 'package:g_zone/UI/signup.dart';
import 'package:g_zone/UI/start_up/default_page.dart';
import 'package:g_zone/api/login_api.dart';
import 'package:get/get.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../app/app.router.dart';
import '../models/jwt.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final PassController = TextEditingController();
  late JWT j;
  final _navigationService = locator<NavigationService>();

  final u = locator<userServices>();

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
              colors: [
            Color(0xff3C4861),
            Color(0xff232f4c),
            Color(0xff192543),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Color(0xff192543),
            title: Text("Login Page"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                //}
                //}
                Get.back();
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
                      style: TextStyle(color: Colors.white),
                      controller: myController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: null,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xff59667d), // <-- Change this
                            fontSize: null,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                          labelText: 'Email',
                          hintText: 'abc@mail.com'),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Enter valid email "),
                        EmailValidator(errorText: "Enter valid email "),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: PassController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: null,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xff59667d), // <-- Change this
                            fontSize: null,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                          labelText: 'Password',
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
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
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
                          j = await LoginApi.postLogin(
                              myController.text, PassController.text);
                          if (j.jwt == "") {
                            AlertDialog(title: Text("Invalid credentials"));
                            myController.clear();
                            PassController.clear();
                          } else {
                            u.jwt = j;
                            _navigationService.navigateTo(Routes.defaultPage);
                          }
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
                              colors: [Color(0xff9af9e9), Color(0xff97eaa3)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  onPressed: () {
                    //}
                    //}
                    _navigationService.navigateTo(Routes.signup);
                    // }
                    //}
                  },
                  child: Text(
                    'Make Account Using Email',
                    style: TextStyle(color: Colors.white, fontSize: 15),
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
