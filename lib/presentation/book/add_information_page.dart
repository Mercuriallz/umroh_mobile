import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mobile_umroh/bloc/region/kabupaten/kabupaten_bloc.dart';
import 'package:mobile_umroh/bloc/region/kabupaten/kabupaten_state.dart';
import 'package:mobile_umroh/bloc/region/kecamatan/kecamatan_bloc.dart';
import 'package:mobile_umroh/bloc/region/kecamatan/kecamatan_state.dart';
import 'package:mobile_umroh/bloc/region/kelurahan/kelurahan_bloc.dart';
import 'package:mobile_umroh/bloc/region/kelurahan/kelurahan_state.dart';
import 'package:mobile_umroh/bloc/region/provinsi/provinsi_bloc.dart';
import 'package:mobile_umroh/bloc/region/provinsi/provinsi_state.dart';
import 'package:mobile_umroh/model/package/package_model.dart';
import 'package:mobile_umroh/presentation/book/book_page.dart';

class AddInformationPage extends StatefulWidget {
  final List<Map<String, String>> existingMembers;
  final DataPackage package;

  const AddInformationPage(
      {super.key, this.existingMembers = const [], required this.package});

  @override
  State<AddInformationPage> createState() => _AddInformationPageState();
}

class _AddInformationPageState extends State<AddInformationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nikController = TextEditingController();

  String? selectedProvince;
  String? selectedRegency;
  String? selectedDistrict;
  String? selectedSubDistrict;

  bool get isFormValid {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        nikController.text.isNotEmpty &&
        selectedProvince != null &&
        selectedRegency != null;
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    nikController.addListener(() => setState(() {}));
    context.read<ProvinsiBloc>().getProvinsi();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    nikController.dispose();
    super.dispose();
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
                Text("Informasi Tambahan"),
                const SizedBox(height: 20),
                buildTextField("Nama", "Masukkan nama Anda", nameController),
                const SizedBox(height: 12),
                buildTextField("NIK", "Masukkan NIK Anda", nikController),
                const SizedBox(height: 12),
                Text("PILIH PROVINSI"),
                BlocBuilder<ProvinsiBloc, ProvinsiState>(
                  builder: (context, state) {
                    debugPrint("Provinsi state: $state");
                    if (state is ProvinsiLoaded) {
                      return FormBuilderDropdown(
                        name: 'provinsiDropdown',
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: const Text('Pilih Provinsi'),
                        items: state.provinsi
                            .map((provinsi) => DropdownMenuItem(
                                  value: provinsi.provinsiId.toString(),
                                  child: Text(provinsi.name.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          debugPrint("Selected regency: $value");
                          setState(() {
                            selectedRegency = value.toString();
                            selectedDistrict = null; // Reset kecamatan
                            debugPrint(
                                "Fetching kecamatan for regency: $selectedRegency");
                            context
                                .read<KabupatenBloc>()
                                .getKabupaten(selectedRegency!);
                          });
                        },
                      );
                    } else if (state is ProvinsiLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return const Text("Gagal memuat data provinsi");
                    }
                  },
                ),
                const SizedBox(height: 12),
                Text("PILIH Kabupaten"),
                BlocBuilder<KabupatenBloc, KabupatenState>(
                  builder: (context, state) {
                    debugPrint("kabupaten state: $state");
                    if (state is KabupatenLoaded) {
                      return FormBuilderDropdown(
                        name: 'kabupatenDropdown',
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onChanged: (value) {
                          debugPrint("Selected regency: $value");
                          setState(() {
                            selectedRegency = value.toString();
                            selectedDistrict = null; // Reset kecamatan
                            debugPrint(
                                "Fetching kecamatan for regency: $selectedRegency");
                            context
                                .read<KecamatanBloc>()
                                .getKecamatan(selectedRegency!);
                          });
                        },
                        hint: const Text('Pilih Kabupaten'),
                        items: state.kabupaten
                            .map((kabupaten) => DropdownMenuItem(
                                  value: kabupaten.kabupatenId.toString(),
                                  child: Text(kabupaten.name.toString()),
                                ))
                            .toList(),
                      );
                    } else if (state is KabupatenLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return const Text("Gagal memuat data kabupaten");
                    }
                  },
                ),
                const SizedBox(height: 12),
                Text("PILIH KECAMATAN"),
                BlocBuilder<KecamatanBloc, KecamatanState>(
                  builder: (context, state) {
                    debugPrint("kecamatan state: $state");
                    if (state is KecamatanLoaded) {
                      return FormBuilderDropdown(
                        name: 'kecamatanDropdown',
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: const Text('Pilih Kecamatan'),
                        items: state.kecamatan
                            .map((kecamatan) => DropdownMenuItem(
                                  value: kecamatan.kecamatanId.toString(),
                                  child: Text(kecamatan.name.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          debugPrint("Selected district: $value");
                          setState(() {
                            selectedDistrict = value.toString();
                            selectedSubDistrict = null; // Reset kelurahan
                          });

                          // Panggil Bloc untuk memuat kelurahan
                          debugPrint(
                              "Fetching kelurahan for district: $selectedDistrict");
                          context
                              .read<KelurahanBloc>()
                              .getKelurahan(selectedDistrict!);
                        },
                      );
                    } else if (state is KecamatanLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return const Text("Gagal memuat data kecamatan");
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Text("PILIH KELURAHAN"),
                BlocBuilder<KelurahanBloc, KelurahanState>(
                  builder: (context, state) {
                    debugPrint("kelurahan state: $state");
                    if (state is KelurahanLoaded) {
                      return FormBuilderDropdown(
                        name: 'kelurahanDropdown',
                        decoration: InputDecoration(
                          labelText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: const Text('Pilih Kelurahan'),
                        items: state.kelurahan
                            .map((kelurahan) => DropdownMenuItem(
                                  value: kelurahan.kelurahanId.toString(),
                                  child: Text(kelurahan.name.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          debugPrint("Selected kelurahan: $value");
                          setState(() {
                            selectedSubDistrict = value.toString();
                          });
                        },
                      );
                    } else if (state is KelurahanLoading) {
                      return const CircularProgressIndicator();
                    } else {
                      return const Text("Gagal memuat data kelurahan");
                    }
                  },
                ),
                buildTextField(
                    "Email", "Masukkan alamat email Anda", emailController),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isFormValid
                        ? () {
                            debugPrint("Submitting form");
                            final formData = {
                              'name': nameController.text,
                              'email': emailController.text,
                              'nik': nikController.text,
                              'province': selectedProvince!,
                              'regency': selectedRegency!,
                            };
                            if (widget.existingMembers.isEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingJemaahPage(
                                    mainMember: formData,
                                    members: [formData],
                                    package: widget.package,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.pop(context, formData);
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor:
                          isFormValid ? const Color(0xFFC81127) : Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      widget.existingMembers.isEmpty
                          ? "Selanjutnya"
                          : "Tambah Anggota",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildTextField(
    String label, String hint, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
      ),
    ],
  );
}
