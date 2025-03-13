import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh/bloc/region/kecamatan/kecamatan_state.dart';
import 'package:mobile_umroh/model/region/kecamatan_model.dart';

class KecamatanBloc extends Cubit<KecamatanState> {
  KecamatanBloc() : super(KecamatanInitial());

  void getKecamatan(String id) async {
    final dio = Dio();

    try {
      final response =
          await dio.get("http://101.50.2.190:8040/v1/wilayah/kecamatan/$id",
              options: Options(headers: {
                "umr_api_key": "CoACeX6XEj",
              }));
      if (response.statusCode == 200) {
        var kecamatanData = KecamatanModel.fromJson(response.data).data;
        emit(KecamatanLoaded(kecamatanData!));
      }
    } catch (e) {
      emit(KecamatanError("Error ${e.toString()}"));
    }
  }
}
