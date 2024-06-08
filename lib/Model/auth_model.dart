import '../Model/user_model.dart';

class AuthModel {
  String? status, token, message;
  User? dataUser;

  AuthModel({
    this.status,
    this.token,
    this.message,
    this.dataUser,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    message = json['message'];
    dataUser = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    data['message'] = message;
    if (dataUser != null) {
      data['user'] = dataUser!.toJson();
    }
    return data;
  }
}
