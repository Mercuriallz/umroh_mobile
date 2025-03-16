import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh/bloc/jemaah/list-jemaah/list_jemaah_state.dart';
import 'package:mobile_umroh/constant/constant.dart';
import 'package:mobile_umroh/model/jemaah/list-jemaah/list_jemaah_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListJemaahBloc extends Cubit<ListJemaahState> {
  ListJemaahBloc() : super(ListJemaahInitial());

  void getListJemaah() async {
    final dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    try {
      final response = await dio.get("$baseUrl/pendaftaran-umroh",
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
       
        var listJemaahData = ListJemaahModel.fromJson(response.data).data;
        emit(ListJemaahLoaded(listJemaahData!));
      }
    } catch (e) {
      emit(ListJemaahError("Error : ${e.toString()}"));
    }
  }
}
