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
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final kadesNameController = TextEditingController();

  String? selectedProvince;
  String? selectedRegency;
  String? selectedDistrict;
  String? selectedSubDistrict;

  bool get isFormValid {
    return nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        kadesNameController.text.isNotEmpty &&
        selectedProvince != null &&
        selectedRegency != null &&
        selectedDistrict != null &&
        selectedSubDistrict != null;
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    addressController.addListener(() => setState(() {}));
    phoneNumberController.addListener(() => setState(() {}));
    kadesNameController.addListener(() => setState(() {}));
    context.read<ProvinsiBloc>().getProvinsi();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    kadesNameController.dispose();
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
                const SizedBox(height: 20),

                // Dropdown Provinsi
                Text("PILIH PROVINSI"),
                BlocBuilder<ProvinsiBloc, ProvinsiState>(
                  builder: (context, state) {
                    if (state is ProvinsiLoaded) {
                      return FormBuilderDropdown(
                        name: 'provinsiDropdown',
                        decoration: _dropdownDecoration(),
                        hint: const Text('Pilih Provinsi'),
                        items: state.provinsi.map((provinsi) {
                          return DropdownMenuItem(
                            value: provinsi.provinsiId.toString(),
                            child: Text(provinsi.name.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedProvince = value.toString();
                            selectedRegency = null;
                            selectedDistrict = null;
                            selectedSubDistrict = null;
                          });
                          context
                              .read<KabupatenBloc>()
                              .getKabupaten(selectedProvince!);
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

                // Dropdown Kabupaten
                Text("PILIH KABUPATEN"),
                BlocBuilder<KabupatenBloc, KabupatenState>(
                  builder: (context, state) {
                    if (state is KabupatenLoaded) {
                      return FormBuilderDropdown(
                        name: 'kabupatenDropdown',
                        decoration: _dropdownDecoration(),
                        hint: const Text('Pilih Kabupaten'),
                        items: state.kabupaten.map((kabupaten) {
                          return DropdownMenuItem(
                            value: kabupaten.kabupatenId.toString(),
                            child: Text(kabupaten.name.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRegency = value.toString();
                            selectedDistrict = null;
                            selectedSubDistrict = null;
                          });
                          context
                              .read<KecamatanBloc>()
                              .getKecamatan(selectedRegency!);
                        },
                      );
                    } else if (state is KabupatenLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return const Text("Pilih Provinsi terlebih dahulu");
                    }
                  },
                ),

                const SizedBox(height: 12),

                // Dropdown Kecamatan
                Text("PILIH KECAMATAN"),
                BlocBuilder<KecamatanBloc, KecamatanState>(
                  builder: (context, state) {
                    if (state is KecamatanLoaded) {
                      return FormBuilderDropdown(
                        name: 'kecamatanDropdown',
                        decoration: _dropdownDecoration(),
                        hint: const Text('Pilih Kecamatan'),
                        items: state.kecamatan.map((kecamatan) {
                          return DropdownMenuItem(
                            value: kecamatan.kecamatanId.toString(),
                            child: Text(kecamatan.name.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistrict = value.toString();
                            selectedSubDistrict = null;
                          });
                          context
                              .read<KelurahanBloc>()
                              .getKelurahan(selectedDistrict!);
                        },
                      );
                    } else if (state is KecamatanLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return const Text("Pilih Kabupaten Terlebih Dahulu");
                    }
                  },
                ),

                const SizedBox(height: 12),

                // Dropdown Kelurahan
                Text("PILIH KELURAHAN"),
                BlocBuilder<KelurahanBloc, KelurahanState>(
                  builder: (context, state) {
                    if (state is KelurahanLoaded) {
                      return FormBuilderDropdown(
                        name: 'kelurahanDropdown',
                        decoration: _dropdownDecoration(),
                        hint: const Text('Pilih Kelurahan'),
                        items: state.kelurahan.map((kelurahan) {
                          return DropdownMenuItem(
                            value: kelurahan.kelurahanId.toString(),
                            child: Text(kelurahan.name.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSubDistrict = value.toString();
                          });
                        },
                      );
                    } else if (state is KelurahanLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return const Text("Pilih Kecamatan terlebih dahulu");
                    }
                  },
                ),

                const SizedBox(height: 12),
                
                Text("NAMA"),
                const SizedBox(height: 8),
                buildTextField("Nama", "Masukkan nama Anda", nameController),
                
                const SizedBox(height: 12),
                
                Text("ALAMAT"),
                const SizedBox(height: 8),
                buildTextField("Alamat", "Masukkan alamat Anda", addressController),
                
                const SizedBox(height: 12),
                
                Text("NAMA KADES"),
                const SizedBox(height: 8),
                buildTextField("Nama Kades", "Masukkan Nama Kades", kadesNameController),
                
                const SizedBox(height: 12),
                
                Text("NOMOR HP"),
                const SizedBox(height: 8),
                buildTextField("Nomor Telepon", "Masukkan No.HP Anda", phoneNumberController),
                
                const SizedBox(height: 20),

                // Tombol Selanjutnya
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isFormValid
                        ? () {
                            debugPrint("Submitting form");
                            final formData = {
                              'name': nameController.text,
                              'address': addressController.text,
                              'kadesName': kadesNameController.text,
                              'phoneNumber': phoneNumberController.text,
                              'province': selectedProvince!,
                              'regency': selectedRegency!,
                              'district': selectedDistrict!,
                              'subdistrict': selectedSubDistrict!,
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
                      backgroundColor: isFormValid ? Colors.red : Colors.grey,
                    ),
                    child: const Text("Selanjutnya",
                        style: TextStyle(color: Colors.white)),
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

// Fungsi untuk TextField
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

InputDecoration _dropdownDecoration() {
  return InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
  );
}