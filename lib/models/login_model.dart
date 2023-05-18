import 'package:json_annotation/json_annotation.dart';

// part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  String? email;
  String? password;
  //String? domain;

  LoginModel({this.email, this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}
