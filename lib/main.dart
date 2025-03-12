import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_umroh/bloc/auth/login/login_bloc.dart';
import 'package:mobile_umroh/presentation/auth/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (_) => LoginBloc())],
      child: MaterialApp(
       builder: EasyLoading.init(), 
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      )));
}
