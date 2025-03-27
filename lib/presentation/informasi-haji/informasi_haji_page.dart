import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh/bloc/jemaah/list-jemaah/list_jemaah_bloc.dart';
import 'package:mobile_umroh/bloc/jemaah/list-jemaah/list_jemaah_state.dart';
import 'package:mobile_umroh/constant/widget/convert_to_rupiah.dart';
import 'package:mobile_umroh/presentation/informasi-haji/informaji_haji_detail_page.dart';

class HajiInformationPage extends StatefulWidget {
  const HajiInformationPage({super.key});

  @override
  State<HajiInformationPage> createState() => HajiInformationPageState();
}

class HajiInformationPageState extends State<HajiInformationPage> {
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<ListJemaahBloc>().getListJemaah(page: currentPage);
  }

  void _changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
    context.read<ListJemaahBloc>().getListJemaah(page: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/haji_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Selamat Datang di Pendaftaran Umroh Desa",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: BlocBuilder<ListJemaahBloc, ListJemaahState>(
                builder: (context, state) {
                  if (state is ListJemaahLoading &&
                      state.dataListJemaah.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ListJemaahLoaded) {
                    return Column(
                      children: [
                        Text("List Keberangkatan Umroh", style: TextStyle(
                          fontSize: 24
                        ),),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.jemaah.length,
                            itemBuilder: (context, index) {
                              var jemaah = state.jemaah[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 4,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  title: Text(
                                    jemaah.tPaket!.namaPaket!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    // "Rp. ${jemaah.tPaket!.harga}",
                                    RupiahConverter().formatToRupiah(int.parse(jemaah.tPaket!.harga.toString())),
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.blueAccent),
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      Get.to(HajiInformationDetailPage(
                                          jemaah: jemaah));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text("Detail",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: currentPage > 1
                                    ? () => _changePage(currentPage - 1)
                                    : null,
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: currentPage > 1
                                      ? Colors.blueAccent
                                      : Colors.grey,
                                ),
                              ),
                              Text(
                                "Halaman $currentPage",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: state.jemaah.length == 10
                                    ? () => _changePage(currentPage + 1)
                                    : null,
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: state.jemaah.length == 10
                                      ? Colors.blueAccent
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: Text("Gagal memuat data."));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
