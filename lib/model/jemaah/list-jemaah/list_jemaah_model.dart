class ListJemaahModel {
  int? status;
  String? message;
  bool? error;
  int? totalResult;
  int? limit;
  int? totalPage;
  List<DataListJemaah>? data;

  ListJemaahModel(
      {this.status,
      this.message,
      this.error,
      this.totalResult,
      this.limit,
      this.totalPage,
      this.data});

  ListJemaahModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
    totalResult = json['total_result'];
    limit = json['limit'];
    totalPage = json['total_page'];
    if (json['data'] != null) {
      data = <DataListJemaah>[];
      json['data'].forEach((v) {
        data!.add(DataListJemaah.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['error'] = error;
    data['total_result'] = totalResult;
    data['limit'] = limit;
    data['total_page'] = totalPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataListJemaah {
  int? pendaftaranId;
  int? userId;
  int? paketId;
  int? provinsiId;
  int? kabupatenId;
  int? kecamatanId;
  String? kelurahanId;
  String? namaKades;
  String? noTelp;
  int? status;
  String? alamatLengkap;
  String? createdAt;
  String? updatedAt;
  UserPendaftar? userPendaftar;
  TPaket? tPaket;
  WProvinsi? wProvinsi;
  WKabupaten? wKabupaten;
  WKecamatan? wKecamatan;
  WKelurahan? wKelurahan;
  List<TAnggotaTambahan>? tAnggotaTambahan;

  DataListJemaah(
      {this.pendaftaranId,
      this.userId,
      this.paketId,
      this.provinsiId,
      this.kabupatenId,
      this.kecamatanId,
      this.kelurahanId,
      this.namaKades,
      this.noTelp,
      this.status,
      this.alamatLengkap,
      this.createdAt,
      this.updatedAt,
      this.userPendaftar,
      this.tPaket,
      this.wProvinsi,
      this.wKabupaten,
      this.wKecamatan,
      this.wKelurahan,
      this.tAnggotaTambahan});

  DataListJemaah.fromJson(Map<String, dynamic> json) {
    pendaftaranId = json['pendaftaran_id'];
    userId = json['user_id'];
    paketId = json['paket_id'];
    provinsiId = json['provinsi_id'];
    kabupatenId = json['kabupaten_id'];
    kecamatanId = json['kecamatan_id'];
    kelurahanId = json['kelurahan_id'];
    namaKades = json['nama_kades'];
    noTelp = json['no_telp'];
    status = json['status'];
    alamatLengkap = json['alamat_lengkap'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userPendaftar = json['user_pendaftar'] != null
        ? UserPendaftar.fromJson(json['user_pendaftar'])
        : null;
    tPaket =
        json['t_paket'] != null ? TPaket.fromJson(json['t_paket']) : null;
    wProvinsi = json['w_provinsi'] != null
        ? WProvinsi.fromJson(json['w_provinsi'])
        : null;
    wKabupaten = json['w_kabupaten'] != null
        ? WKabupaten.fromJson(json['w_kabupaten'])
        : null;
    wKecamatan = json['w_kecamatan'] != null
        ? WKecamatan.fromJson(json['w_kecamatan'])
        : null;
    wKelurahan = json['w_kelurahan'] != null
        ? WKelurahan.fromJson(json['w_kelurahan'])
        : null;
    if (json['t_anggota_tambahan'] != null) {
      tAnggotaTambahan = <TAnggotaTambahan>[];
      json['t_anggota_tambahan'].forEach((v) {
        tAnggotaTambahan!.add(TAnggotaTambahan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pendaftaran_id'] = pendaftaranId;
    data['user_id'] = userId;
    data['paket_id'] = paketId;
    data['provinsi_id'] = provinsiId;
    data['kabupaten_id'] = kabupatenId;
    data['kecamatan_id'] = kecamatanId;
    data['kelurahan_id'] = kelurahanId;
    data['nama_kades'] = namaKades;
    data['no_telp'] = noTelp;
    data['status'] = status;
    data['alamat_lengkap'] = alamatLengkap;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (userPendaftar != null) {
      data['user_pendaftar'] = userPendaftar!.toJson();
    }
    if (tPaket != null) {
      data['t_paket'] = tPaket!.toJson();
    }
    if (wProvinsi != null) {
      data['w_provinsi'] = wProvinsi!.toJson();
    }
    if (wKabupaten != null) {
      data['w_kabupaten'] = wKabupaten!.toJson();
    }
    if (wKecamatan != null) {
      data['w_kecamatan'] = wKecamatan!.toJson();
    }
    if (wKelurahan != null) {
      data['w_kelurahan'] = wKelurahan!.toJson();
    }
    if (tAnggotaTambahan != null) {
      data['t_anggota_tambahan'] =
          tAnggotaTambahan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPendaftar {
  int? userId;
  int? roleId;
  String? email;
  String? password;
  String? noTelp;
  String? name;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  UserPendaftar(
      {this.userId,
      this.roleId,
      this.email,
      this.password,
      this.noTelp,
      this.name,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  UserPendaftar.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
    email = json['email'];
    password = json['password'];
    noTelp = json['no_telp'];
    name = json['name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['role_id'] = roleId;
    data['email'] = email;
    data['password'] = password;
    data['no_telp'] = noTelp;
    data['name'] = name;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class TPaket {
  int? paketId;
  String? namaPaket;
  String? desc;
  String? harga;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? durasiPerjalanan;
  List<TPaketFasilitas>? tPaketFasilitas;

  TPaket(
      {this.paketId,
      this.namaPaket,
      this.desc,
      this.harga,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.durasiPerjalanan,
      this.tPaketFasilitas});

  TPaket.fromJson(Map<String, dynamic> json) {
    paketId = json['paket_id'];
    namaPaket = json['nama_paket'];
    desc = json['desc'];
    harga = json['harga'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    durasiPerjalanan = json['durasi_perjalanan'];
    if (json['t_paket_fasilitas'] != null) {
      tPaketFasilitas = <TPaketFasilitas>[];
      json['t_paket_fasilitas'].forEach((v) {
        tPaketFasilitas!.add(TPaketFasilitas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paket_id'] = paketId;
    data['nama_paket'] = namaPaket;
    data['desc'] = desc;
    data['harga'] = harga;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['durasi_perjalanan'] = durasiPerjalanan;
    if (tPaketFasilitas != null) {
      data['t_paket_fasilitas'] =
          tPaketFasilitas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TPaketFasilitas {
  int? fasilitasId;
  int? paketId;
  String? desc;
  String? createdAt;

  TPaketFasilitas({this.fasilitasId, this.paketId, this.desc, this.createdAt});

  TPaketFasilitas.fromJson(Map<String, dynamic> json) {
    fasilitasId = json['fasilitas_id'];
    paketId = json['paket_id'];
    desc = json['desc'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fasilitas_id'] = fasilitasId;
    data['paket_id'] = paketId;
    data['desc'] = desc;
    data['created_at'] = createdAt;
    return data;
  }
}

class WProvinsi {
  int? provinsiId;
  String? name;
  String? altName;
  String? latitude;
  String? longitude;

  WProvinsi(
      {this.provinsiId,
      this.name,
      this.altName,
      this.latitude,
      this.longitude});

  WProvinsi.fromJson(Map<String, dynamic> json) {
    provinsiId = json['provinsi_id'];
    name = json['name'];
    altName = json['alt_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provinsi_id'] = provinsiId;
    data['name'] = name;
    data['alt_name'] = altName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class WKabupaten {
  int? kabupatenId;
  int? provinsiId;
  String? name;
  String? altName;
  String? latitude;
  String? longitude;

  WKabupaten(
      {this.kabupatenId,
      this.provinsiId,
      this.name,
      this.altName,
      this.latitude,
      this.longitude});

  WKabupaten.fromJson(Map<String, dynamic> json) {
    kabupatenId = json['kabupaten_id'];
    provinsiId = json['provinsi_id'];
    name = json['name'];
    altName = json['alt_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kabupaten_id'] = kabupatenId;
    data['provinsi_id'] = provinsiId;
    data['name'] = name;
    data['alt_name'] = altName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class WKecamatan {
  int? kecamatanId;
  int? kabupatenId;
  String? name;
  String? altName;
  String? latitude;
  String? longitude;

  WKecamatan(
      {this.kecamatanId,
      this.kabupatenId,
      this.name,
      this.altName,
      this.latitude,
      this.longitude});

  WKecamatan.fromJson(Map<String, dynamic> json) {
    kecamatanId = json['kecamatan_id'];
    kabupatenId = json['kabupaten_id'];
    name = json['name'];
    altName = json['alt_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kecamatan_id'] = kecamatanId;
    data['kabupaten_id'] = kabupatenId;
    data['name'] = name;
    data['alt_name'] = altName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class WKelurahan {
  String? kelurahanId;
  int? kecamatanId;
  String? name;
  String? altName;
  String? latitude;
  String? longitude;

  WKelurahan(
      {this.kelurahanId,
      this.kecamatanId,
      this.name,
      this.altName,
      this.latitude,
      this.longitude});

  WKelurahan.fromJson(Map<String, dynamic> json) {
    kelurahanId = json['kelurahan_id'];
    kecamatanId = json['kecamatan_id'];
    name = json['name'];
    altName = json['alt_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kelurahan_id'] = kelurahanId;
    data['kecamatan_id'] = kecamatanId;
    data['name'] = name;
    data['alt_name'] = altName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class TAnggotaTambahan {
  int? anggotaId;
  int? pendaftaranId;
  String? namaAnggota;
  String? nik;
  String? noTelp;
  int? status;
  String? createdAt;
  String? updatedAt;

  TAnggotaTambahan(
      {this.anggotaId,
      this.pendaftaranId,
      this.namaAnggota,
      this.nik,
      this.noTelp,
      this.status,
      this.createdAt,
      this.updatedAt});

  TAnggotaTambahan.fromJson(Map<String, dynamic> json) {
    anggotaId = json['anggota_id'];
    pendaftaranId = json['pendaftaran_id'];
    namaAnggota = json['nama_anggota'];
    nik = json['nik'];
    noTelp = json['no_telp'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['anggota_id'] = anggotaId;
    data['pendaftaran_id'] = pendaftaranId;
    data['nama_anggota'] = namaAnggota;
    data['nik'] = nik;
    data['no_telp'] = noTelp;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}