class PackageModel {
  int? status;
  String? message;
  bool? error;
  int? totalResult;
  int? limit;
  int? totalPage;
  List<DataPackage>? data;

  PackageModel(
      {this.status,
      this.message,
      this.error,
      this.totalResult,
      this.limit,
      this.totalPage,
      this.data});

  PackageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
    totalResult = json['total_result'];
    limit = json['limit'];
    totalPage = json['total_page'];
    if (json['data'] != null) {
      data = <DataPackage>[];
      json['data'].forEach((v) {
        data!.add(DataPackage.fromJson(v));
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

class DataPackage {
  int? paketId;
  String? namaPaket;
  String? desc;
  String? harga;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  DataPackage(
      {this.paketId,
      this.namaPaket,
      this.desc,
      this.harga,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  DataPackage.fromJson(Map<String, dynamic> json) {
    paketId = json['paket_id'];
    namaPaket = json['nama_paket'];
    desc = json['desc'];
    harga = json['harga'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}