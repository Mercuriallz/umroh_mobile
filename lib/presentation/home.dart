import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_umroh/presentation/auth/login.dart';
import 'package:mobile_umroh/presentation/informasi-haji/informasi_haji_page.dart';
import 'package:mobile_umroh/presentation/package/package_umroh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/haji_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.black.withOpacity(0.4),
          //   ),
          // ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ingin melakukan apa hari ini?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildOptionCard(
                          icon: Icons.info_outline,
                          title: "Informasi Umroh",
                          subtitle: "Cek keberangkatan jema’ah umroh",
                          onTap: () {
                            Get.to(HajiInformationPage());
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildOptionCard(
                          icon: Icons.add_circle_outline,
                          title: "Tambahkan Keberangkatan",
                          subtitle: "Tambahkan keberangkatan jema’ah",
                          onTap: () {
                            Get.to(HajiRegistrationPage());
                          },
                        ),
                        const SizedBox(height: 12,),
                        _buildOptionCard(
                          icon: Icons.logout,
                          title: "Log-Out",
                          subtitle: "Log-Out",
                          onTap: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.remove("token");
                            prefs.remove("login");
                            Get.offAll(LoginPage());
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
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.grey.shade700),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
