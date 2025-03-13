import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh/bloc/region/provinsi/provinsi_state.dart';
import 'package:mobile_umroh/model/region/provinsi_model.dart';

class ProvinsiBloc extends Cubit<ProvinsiState> {
  ProvinsiBloc() : super(ProvinsiInitial());

  void getProvinsi() async {
    final dio = Dio();
    try {
      final response =
          await dio.get("http://101.50.2.190:8040/v1/wilayah/provinsi",
              options: Options(headers: {
                "umr_api_key": "CoACeX6XEj",
              }));
      if (response.statusCode == 200) {
        var provinsiData = ProvinceModel.fromJson(response.data).data;
        emit(ProvinsiLoaded(provinsiData!));
      }
    } catch (e) {
      emit(ProvinsiError("error: ${e.toString()}"));
    }
  }
}
