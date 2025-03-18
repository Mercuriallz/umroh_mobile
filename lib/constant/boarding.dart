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

    List<String> imagePaths = [
    "assets/images/ABPEDNAS.png",
    "assets/images/AKSI_1.png",
    "assets/images/APDESI.png",
    "assets/images/logo desa bersatu new.png",
    "assets/images/PARADE.png",
  ];

  Timer? timerCheck;

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? checkLogin = prefs.getBool("login");
    String? token = prefs.getString("token");
    if (kDebugMode) {
      print(checkLogin);
    }
    timerCheck = Timer(const Duration(milliseconds: 3000), () {
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
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        Center(
          child: Image.asset(
            "assets/images/umroh_mobile.png",
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) => 
              Image.asset(
                imagePaths[index],
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    ),
  );
  }
}
