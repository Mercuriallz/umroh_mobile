import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh/bloc/jemaah/list-jemaah/list_jemaah_bloc.dart';
import 'package:mobile_umroh/bloc/jemaah/list-jemaah/list_jemaah_state.dart';
import 'package:mobile_umroh/presentation/informasi-haji/informaji_haji_detail_page.dart';

class HajiInformationPage extends StatefulWidget {
  const HajiInformationPage({super.key});

  @override
  State<HajiInformationPage> createState() => HajiInformationPageState();
}

class HajiInformationPageState extends State<HajiInformationPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ListJemaahBloc>().getListJemaah();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<ListJemaahBloc>().loadMoreJemaah();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/haji_background.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                      child: Column(
                        children: [
                          const Text(
                            "Selamat Datang di Pendaftaran Umroh Desa",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Silahkan pilih paket terlebih dahulu:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                BlocBuilder<ListJemaahBloc, ListJemaahState>(
                                  builder: (context, state) {
                                    if (state is ListJemaahLoading && state.dataListJemaah.isEmpty) {
                                      return const SizedBox();
                                    } else if (state is ListJemaahLoaded) {
                                      return Column(
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: state.jemaah.length,
                                            itemBuilder: (context, index) {
                                              var jemaah = state.jemaah[index];
                                              return Container(
                                                margin: const EdgeInsets.symmetric(vertical: 8),
                                                padding: const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey.shade300,
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            jemaah.tPaket!.namaPaket!,
                                                            style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 4),
                                                          Text(
                                                            "Rp. ${jemaah.tPaket!.harga}",
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.blueAccent,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Get.to(HajiInformationDetailPage(jemaah: jemaah));
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.blueAccent,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        "Detail",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          if (state.isLoadingMore)
                                            const SizedBox()
                                        ],
                                      );
                                    } else {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
