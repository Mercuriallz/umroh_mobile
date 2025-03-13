import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh/bloc/region/kabupaten/kabupaten_state.dart';
import 'package:mobile_umroh/model/region/kabupaten_model.dart';

class KabupatenBloc extends Cubit<KabupatenState> {
  KabupatenBloc() : super(KabupatenInitial());

  void getKabupaten(String id) async {
    final dio = Dio();

    try {
      final response =
          await dio.get("http://101.50.2.190:8040/v1/wilayah/kabupaten/$id",
              options: Options(headers: {
                "umr_api_key": "CoACeX6XEj",
              }));
      if (response.statusCode == 200) {
        var kabupatenData = KabupatenModel.fromJson(response.data).data;
        emit(KabupatenLoaded(kabupatenData!));
      }
    } catch (e) {
      emit(KabupatenError("Error ${e.toString()}"));
    }
  }
}
