import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginResponseModel {
  String? token;
  String? error;
  String? category;
  List<DomainModel>? domains;

  LoginResponseModel({
    this.token,
    this.error,
    this.category,
    this.domains,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    var domainList = json['domains'] as List?;
    List<DomainModel> parsedDomainList = [];
    print("res: $domainList");
    if (domainList != null) {
      parsedDomainList =
          domainList.map((d) => DomainModel.fromJson(d)).toList();
    }
    return LoginResponseModel(
        error: json['error'] as String?,
        token: json['token'] as String?,
        category: json['category'] as String?,
        domains: parsedDomainList);
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'error': error,
      'category': category,
      'domains': domains
    };
  }
}

class DomainModel {
  String? name;
  String? host;
  DomainModel({this.name, this.host});

  factory DomainModel.fromJson(Map<String, dynamic> json) {
    return DomainModel(
      name: json['name'] as String?,
      host: json['host'] as String?,
    );
  }
  Map<String, dynamic> tojson() {
    return {'name': name, 'host': host};
  }
}
