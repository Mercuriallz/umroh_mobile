import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_umroh/bloc/auth/login/login_state.dart';
import 'package:mobile_umroh/model/auth/login/login_model.dart';
import 'package:mobile_umroh/model/auth/login/login_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginInitial());

  Future<LoginModel> login({LoginRequestModel? formData}) async {
    final dio = Dio();
    EasyLoading.show(status: "Loading");
    

    Map<String, dynamic> dataLogin = {
      'email': formData!.email,
      'password': formData.password,
    };

    try {
      final response = await dio.post(
        "http://101.50.2.190:8040/v1/auth/user/sign-in",
        data: dataLogin,
        options:  Options(
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "umr_api_key": "CoACeX6XEj", 
      },
    ),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        print("respon data --> ${response.data}");

        print("username ==> ${formData.email}");
        print("password ==> ${formData.password}");
        emit(LoginSuccess());

        var loginModel = LoginModel.fromJson(response.data);
        var token = loginModel.token;
        print("Token --> $token");

        if (token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", token);
        }

        return loginModel;

      } else {
        EasyLoading.dismiss();
        throw Exception("Login gagal dengan status code: ${response.statusCode}");
      }
    } catch (e) {
      EasyLoading.dismiss();
      emit(LoginError(e.toString()));
      throw Exception("Terjadi kesalahan saat login: $e");
    }
  }
}
