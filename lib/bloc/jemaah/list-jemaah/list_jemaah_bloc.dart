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
  List<DataListJemaah> jemaahList = [];

  void getListJemaah() async {
    currentPage = 1;
    jemaahList.clear();
    fetchJemaah();
  }

  void loadMoreJemaah() {
    if (!isFetching) {
      currentPage++;
      fetchJemaah(isLoadMore: true);
    }
  }

  Future<void> fetchJemaah({bool isLoadMore = false}) async {
    isFetching = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    try {
      final response = await _dio.get(
        "$baseUrl/pendaftaran-umroh?page=$currentPage",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        var listJemaahData = ListJemaahModel.fromJson(response.data).data;
        if (listJemaahData != null) {
          jemaahList.addAll(listJemaahData);
          emit(ListJemaahLoaded(jemaahList, isLoadingMore: isLoadMore));
        }
      }
    } catch (e) {
      emit(ListJemaahError("Error: ${e.toString()}"));
    } finally {
      isFetching = false;
    }
  }
}