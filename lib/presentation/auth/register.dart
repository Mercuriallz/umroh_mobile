import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh/bloc/auth/register/register_bloc.dart';
import 'package:mobile_umroh/bloc/region/provinsi/provinsi_bloc.dart';
import 'package:mobile_umroh/model/auth/register/register_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final noTelpController = TextEditingController();

  String? selectedProvince;
  String? selectedRegency;
  String? selectedDistrict;
  String? selectedSubDistrict;

  @override
  void initState() {
    super.initState();
    context.read<ProvinsiBloc>().getProvinsi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tambahkan Informasi",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                // Dropdown Provinsi

                const SizedBox(height: 12),

                Text("Email"),
                const SizedBox(height: 8),
                buildTextField("Email", "Masukkan email Anda", emailController),

                const SizedBox(height: 12),

                Text("Password"),
                const SizedBox(height: 8),
                buildTextField(
                    "Password", "Masukkan Password Anda", passwordController),

                const SizedBox(height: 12),

                Text("NAMA"),
                const SizedBox(height: 8),
                buildTextField(
                    "Nama", "Masukkan Nama", nameController),

                const SizedBox(height: 12),

                Text("NOMOR HP"),
                const SizedBox(height: 8),
                buildTextField("Nomor Telepon", "Masukkan No.HP Anda",
                    noTelpController),

                const SizedBox(height: 20),

                // Tombol Selanjutnya
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final data = RegisterModel(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        noTelp: noTelpController.text
                      );
                      context.read<RegisterBloc>().register(data);
                    },
                    child: const Text("Daftar sekarang!",
                        style: TextStyle(color: Colors.blue)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  // InputDecoration _dropdownDecoration() {
  //   return InputDecoration(
  //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
  //   );
  // }
}
