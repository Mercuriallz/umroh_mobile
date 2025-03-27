import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh/bloc/jemaah/list-jemaah/list_jemaah_state.dart';
import 'package:mobile_umroh/constant/constant.dart';
import 'package:mobile_umroh/model/jemaah/list-jemaah/list_jemaah_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListJemaahBloc extends Cubit<ListJemaahState> {
  ListJemaahBloc() : super(ListJemaahInitial());

  final  dio = Dio();
  int currentPage = 1;
  bool isFetching = false;
  bool hasMoreData = true; 
  List<DataListJemaah> jemaahList = [];

  void getListJemaah({int page = 1}) async {
    if (isFetching) return;
    isFetching = true;

    if (page == 1) {
      jemaahList.clear(); 
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    try {
      final response = await dio.get(
        "$baseUrl/pendaftaran-umroh?page=$page",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        var listJemaahData = ListJemaahModel.fromJson(response.data).data ?? [];

        hasMoreData = listJemaahData.length == 10; 

        jemaahList = listJemaahData; 
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
