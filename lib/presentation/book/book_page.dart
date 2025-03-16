import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh/bloc/jemaah/regist-jemaah/regist_jemaah_bloc.dart';
import 'package:mobile_umroh/model/jemaah/regist-jemaah/regist_jemaah_model.dart';
// import 'package:intl/intl.dart';
import 'package:mobile_umroh/model/package/package_model.dart';
import 'package:mobile_umroh/presentation/book/add_jemaah_page.dart';

class BookingJemaahPage extends StatefulWidget {
  final Map<String, String> mainMember;
  final List<Map<String, String>> members;
  final DataPackage package;

  const BookingJemaahPage({
    super.key,
    required this.mainMember,
    required this.members,
    required this.package,
  });

  @override
  State<BookingJemaahPage> createState() => _BookingJemaahPageState();
}

class _BookingJemaahPageState extends State<BookingJemaahPage> {
  final TextEditingController dateController = TextEditingController();
  late List<Map<String, String>> jemaahList;

  @override
  void initState() {
    super.initState();
    jemaahList = List.from(widget.members);
  }

  void _addJemaah() async {
    final newMember = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => AddJemaahPage(
          existingMembers: jemaahList,
          package: widget.package,
        ),
      ),
    );

    if (newMember != null) {
      setState(() {
        jemaahList.add(newMember);
      });
    }
  }

  void removeJemaah(int index) {
    setState(() {
      jemaahList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/haji_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Custom App Bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: const [
                            Icon(Icons.chevron_left, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'Kembali',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Content area
                Expanded(
                  child: Stack(
                    children: [
                      // Scrollable content
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Package Card
                              Card(
                                margin: const EdgeInsets.only(bottom: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.package.namaPaket ??
                                                  "Paket",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              widget.package.harga ?? "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF3256B2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text(
                                          "Detail",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Informasi Jema'ah
                              const Padding(
                                padding:
                                    EdgeInsets.only(left: 8, bottom: 8, top: 8),
                                child: Text(
                                  "Informasi Jema'ah :",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              // Main member card
                              Card(
                                margin: const EdgeInsets.only(bottom: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.mainMember["name"] ?? "",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            widget.mainMember["phoneNumber"] ??
                                                "",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          //  Text(
                                          //   widget.mainMember["kadesName"] ?? "",
                                          //   style: const TextStyle(
                                          //     fontSize: 14,
                                          //     color: Colors.grey,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Alamat: ${widget.mainMember["address"] ?? ""}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Kades: ${widget.mainMember["kadesName"] ?? ""}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // List Jema'ah
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "List Jema'ah (${jemaahList.length})",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Jemaah list
                                      ...jemaahList
                                          .map((jemaah) =>
                                              _buildJemaahCard(jemaah)).toList(),
                                          

                                      // Add Jemaah button
                                      const SizedBox(height: 16),
                                      SizedBox(
                                        width: double.infinity,
                                        child: OutlinedButton(
                                          onPressed: _addJemaah,
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            side: const BorderSide(
                                                color: Color(0xFF3256B2)),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            "Tambah Jema'ah",
                                            style: TextStyle(
                                              color: Color(0xFF3256B2),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Register button at bottom
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            // print("Button pressed");

                            // Membuat list anggota tanpa mainMember
                            var anggotaList = jemaahList
                                .map((jemaah) => Anggota(
                                      namaAnggota: jemaah["name"],
                                      nik: jemaah["nik"],
                                      noTelp: jemaah["no_telp"],
                                    ))
                                .toList();

                            // Buang anggota pertama jika itu adalah mainMember
                            if (anggotaList.isNotEmpty &&
                                anggotaList.first.namaAnggota ==
                                    widget.mainMember["name"]) {
                              anggotaList.removeAt(0);
                            }

                            var data = RegistJemaahModel(
                              paketId: widget.package.paketId.toString(),
                              provinsiId: widget.mainMember["province"] ?? "",
                              kabupatenId: widget.mainMember["regency"] ?? "",
                              kecamatanId: widget.mainMember["district"] ?? "",
                              kelurahanId:
                                  widget.mainMember["subdistrict"] ?? "",
                              namaKades: widget.mainMember["kadesName"] ?? "",
                              noTelp: widget.mainMember["phoneNumber"] ?? "",
                              anggota: anggotaList,
                            );

                            context.read<RegistJemaahBloc>().registJemaah(data);
                            // print(data
                            //     .toJson()); // Debugging untuk memastikan data sudah benar
                          },
                          child: Container(
                            width: double.infinity,
                            color: const Color(0xFF3256B2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: const Text(
                              "Daftarkan Sekarang",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJemaahCard(Map<String, String> jemaah) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                jemaah["name"] ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                jemaah["no_telp"] ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "NIK: ${jemaah["nik"] ?? ""}",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
