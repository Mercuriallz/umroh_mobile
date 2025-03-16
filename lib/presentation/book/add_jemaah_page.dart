import 'package:flutter/material.dart';
import 'package:mobile_umroh/model/package/package_model.dart';
import 'package:mobile_umroh/presentation/book/book_page.dart';

class AddJemaahPage extends StatefulWidget {
  final List<Map<String, String>> existingMembers;
  final DataPackage package;

  const AddJemaahPage(
      {super.key, this.existingMembers = const [], required this.package});

  @override
  State<AddJemaahPage> createState() => _AddJemaahPageState();
}

class _AddJemaahPageState extends State<AddJemaahPage> {
  final nameController = TextEditingController();
  final nikController = TextEditingController();
  final noTelpController = TextEditingController();

  void updateFormState() {
    setState(() {});
  }

  bool get isFormValid {
    return nameController.text.isNotEmpty &&
        nikController.text.isNotEmpty &&
        noTelpController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(updateFormState);
    nikController.addListener(updateFormState);
    noTelpController.addListener(updateFormState);
  }

  @override
  void dispose() {
    nameController.dispose();
    nikController.dispose();
    noTelpController.dispose();
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

                const SizedBox(height: 12),

                Text("NAMA"),
                const SizedBox(height: 8),
                buildTextField("Nama", "Masukkan nama Anda", nameController),

                const SizedBox(height: 12),

                Text("NIK"),
                const SizedBox(height: 8),
                buildTextField("NIK", "Masukkan Nik Anda", nikController),

                const SizedBox(
                  height: 12,
                ),

                Text("NOMOR HP"),
                const SizedBox(height: 8),
                buildTextField(
                    "Nomor Telepon", "Masukkan No.HP Anda", noTelpController),

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
                              'nik': nikController.text,
                              'no_telp': noTelpController.text
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
                      backgroundColor: isFormValid ? Colors.blue : Colors.grey,
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
