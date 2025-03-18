import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh/bloc/jemaah/regist-jemaah/regist_jemaah_state.dart';
import 'package:mobile_umroh/constant/constant.dart';
import 'package:mobile_umroh/model/jemaah/regist-jemaah/regist_jemaah_model.dart';
import 'package:mobile_umroh/presentation/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistJemaahBloc extends Cubit<RegistJemaahState> {
  RegistJemaahBloc() : super(RegisterJemaahInitial());

  void registJemaah(RegistJemaahModel formData) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  Map<String, dynamic> registData = {
    "paket_id": formData.paketId,
    "provinsi_id": formData.provinsiId,
    "kabupaten_id": formData.kabupatenId,
    "kecamatan_id": formData.kecamatanId,
    "kelurahan_id": formData.kelurahanId,
    "alamat_lengkap": formData.alamatLengkap,
    "nama_kades": formData.namaKades,
    "no_telp": formData.noTelp,
    "anggota": formData.anggota != null
        ? formData.anggota!.map((anggota) => {
              "nama_anggota": anggota.namaAnggota,
              "nik": anggota.nik,
              "no_telp": anggota.noTelp,
            }).toList()
        : [],
  };

  try {
    final response = await dio.post(
      "$baseUrl/pendaftaran-umroh",
      data: registData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/x-www-form-urlencoded',
        },
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Status Code: ${response.statusCode}, Emit Success State");
      print("Response data --> ${response.data}");
      print("Regist data --> $registData");
      emit(RegisterJemaahSuccess());
      Get.snackbar(
        "Success",
        "Data berhasil dikirim!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Get.theme.scaffoldBackgroundColor,
      );
      Get.offAll(HomePage());
    } 
  } catch (e) {
    if (e is DioException) {
      print("Dio Error: ${e.response?.data}");
      emit(RegisterJemaahError("Dio Error: ${e.response?.data}"));
    } else {
      print("General Error: ${e.toString()}");
      emit(RegisterJemaahError("Error: ${e.toString()}"));
    }
  }
}

}