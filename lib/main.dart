import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh/bloc/auth/login/login_bloc.dart';
import 'package:mobile_umroh/bloc/package/package_bloc.dart';
import 'package:mobile_umroh/bloc/region/kabupaten/kabupaten_bloc.dart';
import 'package:mobile_umroh/bloc/region/kecamatan/kecamatan_bloc.dart';
import 'package:mobile_umroh/bloc/region/kelurahan/kelurahan_bloc.dart';
import 'package:mobile_umroh/bloc/region/provinsi/provinsi_bloc.dart';
import 'package:mobile_umroh/constant/boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(kReleaseMode) {
    await dotenv.load(fileName: ".env.production");
  } else {
    await dotenv.load(fileName: ".env.development");
  }
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => PackageBloc()),
        BlocProvider(create: (_) => ProvinsiBloc()),
        BlocProvider(create: (_) => KabupatenBloc()),
        BlocProvider(create: (_) => KecamatanBloc()),
        BlocProvider(create: (_) => KelurahanBloc())
        ],
      child: GetMaterialApp(
       builder: EasyLoading.init(), 
        debugShowCheckedModeBanner: false,
        home: BoardingScreen(),
      )));
}
