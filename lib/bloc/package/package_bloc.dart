import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh/bloc/package/package_state.dart';
import 'package:mobile_umroh/model/package/package_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageBloc extends Cubit<PackageState> {
  PackageBloc() : super(PackageInitial());

  void getPackage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final dio = Dio();

    try {
      final response = await dio.get("http://101.50.2.190:8040/v1/paket",
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        var packageModel = PackageModel.fromJson(response.data).data;
        emit(PackageLoaded(packageModel!));
      }
    } catch (e) {
      emit(PackageError("Error: ${e.toString()}"));
    }
  }
}
