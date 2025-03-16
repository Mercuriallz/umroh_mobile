import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh/bloc/auth/register/register_state.dart';
import 'package:mobile_umroh/constant/constant.dart';
import 'package:mobile_umroh/model/auth/register/register_model.dart';
import 'package:mobile_umroh/presentation/auth/login.dart';

class RegisterBloc extends Cubit<RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  void register(RegisterModel formData) async {
    final dio = Dio();

    Map<String, dynamic> registData = {
      "email": formData.email,
      "password": formData.password,
      "name": formData.name,
      "no_telp": formData.noTelp
    };

    try {
      final response = await dio.post(
        "$baseUrl/auth/user/sign-up", 
        data: registData,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "umr_api_key": apiKey,
          }
        )
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print("data json yg dikirim --> $registData");
        emit(RegisterSuccess());
        Get.snackbar(
          "Success", 
          "Registration successful",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Get.theme.scaffoldBackgroundColor,
        );
        Get.offAll(LoginPage());
      }
    } catch (e) {
      emit(RegisterFailed("Error: ${e.toString()}"));
    }
  }
}
