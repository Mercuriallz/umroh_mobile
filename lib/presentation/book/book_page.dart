import 'package:flutter/material.dart';
import 'package:mobile_umroh/model/package/package_model.dart';
import 'package:mobile_umroh/presentation/book/add_information_page.dart';


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

  bool get isFormValid => dateController.text.isNotEmpty && jemaahList.isNotEmpty;

  // Future<void> _selectDate() async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2100),
  //   );

  //   if (pickedDate != null) {
  //     setState(() {
  //       dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
  //     });
  //   }
  // }

  void _addJemaah() async {
    final newMember = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => AddInformationPage(
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
      appBar: AppBar(
        title: const Text(
          'Form Pemesanan',
          style: TextStyle(color: Colors.white)
        ),
        backgroundColor: const Color(0xFFC81127),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Paket Haji Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
               
              ),
              child: Row(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(8),
                  //   child: Image.asset(
                  //     "assets/images/kabah.png",
                  //     width: 70,
                  //     height: 70,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  // const SizedBox(width: 12),
                   Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.package.namaPaket!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          )
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.package.harga ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red
                          )
                        ),
                        SizedBox(height: 4),
                        // Row(
                        //   children: [
                        //     Icon(Icons.remove_red_eye, size: 14, color: Colors.grey),
                        //     SizedBox(width: 4),
                        //     Text("${widget.package['views']} views", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            buildTextField(
              "Tanggal Keberangkatan",
              "DD/MM/YYYY",
              dateController,
              readOnly: true,
              // onTap: _selectDate,
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Jumlah Jema'ah",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
                ),
                Text(
                  "${jemaahList.length}",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
                ),
              ],
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: jemaahList.length,
              itemBuilder: (context, index) {
                final jemaah = jemaahList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      jemaah["name"] ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    subtitle: Text(
                      "NIK: ${jemaah["nik"]}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => removeJemaah(index),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildDetailRow("Email", jemaah["email"] ?? ''),
                            _buildDetailRow("Provinsi", jemaah["province"] ?? ''),
                            _buildDetailRow("Kabupaten", jemaah["regency"] ?? ''),
                            _buildDetailRow("Kecamatan", jemaah["district"] ?? ''),
                            _buildDetailRow("Desa", jemaah["village"] ?? ''),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Tombol Tambah Anggota
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _addJemaah,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
                child: const Text(
                  "+ Tambah Anggota",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  )
                ),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isFormValid ? () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ConfirmBookingPage(
                  //       mainMember: widget.mainMember,
                  //       members: jemaahList,
                  //       package: widget.package,
                  //       departureDate: dateController.text,
                  //     ),
                  //   ),
                  // );
                  // print("Verifikasi booking dengan ${jemaahList.length} jemaah");
                  // print("Tanggal keberangkatan: ${dateController.text}");
                } : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: isFormValid ? const Color(0xFFC81127) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
                child: const Text(
                  "Verifikasi Booking",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
    String label,
    String hint,
    TextEditingController controller, {
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}