import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh/bloc/jemaah/list-jemaah/list_jemaah_state.dart';
import 'package:mobile_umroh/constant/constant.dart';
import 'package:mobile_umroh/model/jemaah/list-jemaah/list_jemaah_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListJemaahBloc extends Cubit<ListJemaahState> {
  ListJemaahBloc() : super(ListJemaahInitial());

  final Dio _dio = Dio();
  int currentPage = 1;
  bool isFetching = false;
  bool hasMoreData = true; // Menentukan apakah masih ada data untuk halaman berikutnya
  List<DataListJemaah> jemaahList = [];

  void getListJemaah({int page = 1}) async {
    if (isFetching) return;
    isFetching = true;

    if (page == 1) {
      jemaahList.clear(); // Reset data jika halaman pertama
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    try {
      final response = await _dio.get(
        "$baseUrl/pendaftaran-umroh?page=$page",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        var listJemaahData = ListJemaahModel.fromJson(response.data).data ?? [];

        hasMoreData = listJemaahData.length == 10; // Jika kurang dari 10, berarti tidak ada halaman berikutnya

        jemaahList = listJemaahData; // Simpan hanya data dari halaman ini
        emit(ListJemaahLoaded(jemaahList, isLoadingMore: false));
      }
    } catch (e) {
      emit(ListJemaahError("Error: ${e.toString()}"));
    } finally {
      isFetching = false;
      currentPage = page;
    }
  }
}
