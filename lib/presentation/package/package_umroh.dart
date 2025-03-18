import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh/bloc/package/package_bloc.dart';
import 'package:mobile_umroh/bloc/package/package_state.dart';
import 'package:mobile_umroh/presentation/package/detail_package.dart';

class HajiRegistrationPage extends StatefulWidget {
  const HajiRegistrationPage({super.key});

  @override
  State<HajiRegistrationPage> createState() => _HajiRegistrationPageState();
}

class _HajiRegistrationPageState extends State<HajiRegistrationPage> {
  @override
  void initState() {
    super.initState();
    context.read<PackageBloc>().getPackage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/haji_background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                          const SizedBox(height: 8),
                          const Text(
                            "Mempermudah anda dalam mendaftarkan serta memberangkatkan anda untuk pergi beribadah dengan lebih mudah dan aman.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Silahkan pilih paket terlebih dahulu:",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                BlocBuilder<PackageBloc, PackageState>(
                                  builder: (context, state) {
                                    if (state is PackageInitial) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (state is PackageLoaded) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: state.package.length,
                                        itemBuilder: (context, index) {
                                          var package = state.package[index];
                                          return Container(
                                            margin: const EdgeInsets.symmetric(vertical: 8),
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
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
                                                              package.namaPaket!,
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                            const SizedBox(height: 4),
                                                            Text(
                                                              "Rp. ${package.harga}",
                                                              style: const TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.blueAccent,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Get.to(PackageDetailPage(package: package));
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
                                      );
                                    } else {
                                      return const Center(
                                          child: Text("Gagal memuat data."));
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}