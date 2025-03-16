import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_umroh/bloc/jemaah/list-jemaah/list_jemaah_bloc.dart';
import 'package:mobile_umroh/constant/widget/bullet_point.dart';
import 'package:mobile_umroh/model/jemaah/list-jemaah/list_jemaah_model.dart';

class HajiInformationDetailPage extends StatefulWidget {
  final DataListJemaah jemaah;

  const HajiInformationDetailPage({super.key, required this.jemaah});

  @override
  State<HajiInformationDetailPage> createState() => HajiInformationDetailPageState();
}

class HajiInformationDetailPageState extends State<HajiInformationDetailPage> {

  @override  
  void initState() {
    super.initState();
    context.read<ListJemaahBloc>().getListJemaah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Paket"),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.jemaah.tPaket!.namaPaket!,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      widget.jemaah.namaKades!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                     Text(widget.jemaah.noTelp!),
                    const SizedBox(height: 8),
                    const Text("Jln. H. Ateng 3 No.50 RT.005/RW.20, Kec. Sumajaya, Kel. Baktijaya, Depok, Jawa Barat"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Lama Perjalanan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
               Text(widget.jemaah.tPaket!.durasiPerjalanan!),
              const SizedBox(height: 16),
              const Text(
                "Fasilitas",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.jemaah.tPaket!.tPaketFasilitas!
                  .map((fasilitas) => BulletPoint(text: fasilitas.desc!))
                  .toList(),
            ),
              const SizedBox(height: 16),
              // Text(
              //   "List Jema’ah ($totalJemaah)",
              //   style: const TextStyle(fontWeight: FontWeight.bold),
              // ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.jemaah.tAnggotaTambahan!.length,
                itemBuilder: (context, index) {
                  final jemaah = widget.jemaah.tAnggotaTambahan![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jemaah.namaAnggota!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(jemaah.noTelp!),
                        Text(jemaah.nik!),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Oke, Selesai",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
