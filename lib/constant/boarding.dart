import 'dart:async';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:mobile_umroh/presentation/auth/login.dart';
import 'package:mobile_umroh/presentation/home.dart';

import 'package:shared_preferences/shared_preferences.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingState();
}

class _BoardingState extends State<BoardingScreen> {
  Timer? timerCheck;

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? checkLogin = prefs.getBool("login");
    String? token = prefs.getString("token");
    if (kDebugMode) {
      print(checkLogin);
    }
    timerCheck = Timer(const Duration(milliseconds: 500), () {
      if (token != null && checkLogin == true) {
        Get.offAll(const HomePage());
      } else {
        Get.offAll(const LoginPage());
      }
    });
  }

  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  @override
  void dispose() {
    super.dispose();
    timerCheck?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/haji_background.png", fit: BoxFit.contain),
          const SizedBox(
            height: 10,
          ),
          const Text("Umroh",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      )),
    );
  }
}
