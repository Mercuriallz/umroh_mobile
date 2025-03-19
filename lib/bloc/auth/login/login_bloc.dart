import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh/bloc/auth/login/login_state.dart';
import 'package:mobile_umroh/constant/constant.dart';
import 'package:mobile_umroh/model/auth/login/login_model.dart';
import 'package:mobile_umroh/model/auth/login/login_request_model.dart';
import 'package:mobile_umroh/presentation/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginInitial());

  Future<LoginModel> login({LoginRequestModel? formData}) async {
    if (formData == null) {
      emit(LoginError("Data login tidak boleh kosong"));
      Get.snackbar(
        "Login Gagal",
        "Data login tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      throw Exception("Data login tidak boleh kosong");
    }

    final dio = Dio();
    EasyLoading.show(status: "Loading");

    Map<String, dynamic> dataLogin = {
      'email': formData.email,
      'password': formData.password,
    };

    try {
      final response = await dio.post(
        "$baseUrl/auth/user/sign-in",
        data: dataLogin,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "umr_api_key": apiKey,
          },
        ),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        emit(LoginSuccess());

        var loginModel = LoginModel.fromJson(response.data);
        var token = loginModel.token;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token!);

        Get.snackbar(
          "Login Berhasil",
          "Selamat datang!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary,
          colorText: Get.theme.colorScheme.onPrimary,
        );

        Get.offAll(HomePage());
        return loginModel;
      } 
      else if (response.statusCode == 400) {
        EasyLoading.dismiss();

        String errorMessage = response.data?['message'] ?? "Email atau password salah.";
        emit(LoginError(errorMessage));

        Get.snackbar(
          "Login Gagal",
          "Username atau Password Salah",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );

        throw Exception(errorMessage);
      } 
      else {
        EasyLoading.dismiss();
        String errorMessage = "Login gagal dengan status code: ${response.statusCode}";

        Get.snackbar(
          "Login Gagal",
          "Username atau Password Salah",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );

        throw Exception(errorMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();
      emit(LoginError(e.toString()));

      // Tampilkan Snackbar error
      Get.snackbar(
        "Terjadi Kesalahan",
        "Username atau Password Salah",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );

      throw Exception("Terjadi kesalahan saat login: $e");
    }
  }
}
