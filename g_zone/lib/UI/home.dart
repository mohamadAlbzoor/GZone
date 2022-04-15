
import 'package:flutter/material.dart';
import 'package:g_zone/UI/login.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
          Get.to(() => LoginScreen());
          },
          child: const Text('go to login!'),
        ),
      ),
    );
  }
}