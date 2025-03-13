import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh/bloc/region/kelurahan/kelurahan_state.dart';
import 'package:mobile_umroh/model/region/kelurahan_model.dart';

class KelurahanBloc extends Cubit<KelurahanState> {
  KelurahanBloc() : super(KelurahanInitial());

  void getKelurahan(String id) async {
    final dio = Dio();

    try {
      final response =
          await dio.get("http://101.50.2.190:8040/v1/wilayah/kelurahan/$id",
              options: Options(headers: {
                "umr_api_key": "CoACeX6XEj",
              }));

      if (response.statusCode == 200) {
        var kelurahanData = KelurahanModel.fromJson(response.data).data;
        emit(KelurahanLoaded(kelurahanData!));
      }
    } catch (err) {
      emit(KelurahanError("Error ${err.toString()}"));
    }
  }
}
