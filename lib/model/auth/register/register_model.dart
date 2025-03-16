class RegisterModel {
  String? email;
  String? password;
  String? name;
  String? noTelp;

  RegisterModel({this.email, this.password, this.name, this.noTelp});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    noTelp = json['no_telp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['no_telp'] = noTelp;
    return data;
  }
}