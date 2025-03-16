class RegistJemaahModel {
  String? paketId;
  String? provinsiId;
  String? kabupatenId;
  String? kecamatanId;
  String? kelurahanId;
  String? namaKades;
  String? noTelp;
  List<Anggota>? anggota;

  RegistJemaahModel(
      {this.paketId,
      this.provinsiId,
      this.kabupatenId,
      this.kecamatanId,
      this.kelurahanId,
      this.namaKades,
      this.noTelp,
      this.anggota});

  RegistJemaahModel.fromJson(Map<String, dynamic> json) {
    paketId = json['paket_id'];
    provinsiId = json['provinsi_id'];
    kabupatenId = json['kabupaten_id'];
    kecamatanId = json['kecamatan_id'];
    kelurahanId = json['kelurahan_id'];
    namaKades = json['nama_kades'];
    noTelp = json['no_telp'];
    if (json['anggota'] != null) {
      anggota = <Anggota>[];
      json['anggota'].forEach((v) {
        anggota!.add(Anggota.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paket_id'] = paketId;
    data['provinsi_id'] = provinsiId;
    data['kabupaten_id'] = kabupatenId;
    data['kecamatan_id'] = kecamatanId;
    data['kelurahan_id'] = kelurahanId;
    data['nama_kades'] = namaKades;
    data['no_telp'] = noTelp;
    if (anggota != null) {
      data['anggota'] = anggota!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Anggota {
  String? namaAnggota;
  String? nik;
  String? noTelp;

  Anggota({this.namaAnggota, this.nik, this.noTelp});

  Anggota.fromJson(Map<String, dynamic> json) {
    namaAnggota = json['nama_anggota'];
    nik = json['nik'];
    noTelp = json['no_telp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_anggota'] = namaAnggota;
    data['nik'] = nik;
    data['no_telp'] = noTelp;
    return data;
  }
}