import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

// To parse this JSON data, do
//
//  final createJobResponseModel = createJobResponseModelFromJson(jsonString);
List<CreateJobResponseModel> createJobResponseModelFromJson(String str) =>
    List<CreateJobResponseModel>.from(
        json.decode(str).map((x) => CreateJobResponseModel.fromJson(x)));

String createJobResponseModelToJson(List<CreateJobResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
// class CreateJobsResponseModel {
//   List<CreateJobResponseModel>? createJobData;
//   CreateJobsResponseModel({
//     this.createJobData,
//   });
//   factory CreateJobsResponseModel.fromJson(Map<String, dynamic> json) {
//     return CreateJobsResponseModel(
//       createJobData: List<CreateJobResponseModel>.from(
//           json["createJobData"].map((x) => CreateJobResponseModel.fromJson(x))),
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       "createJobData":
//           List<dynamic>.from(createJobData!.map((e) => e.toJson())),
//     };
//   }
// }

class CreateJobResponseModel {
  String? id;
  String? name;
  String? address;

  CreateJobResponseModel({
    this.id,
    this.name,
    this.address,
  });

  factory CreateJobResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateJobResponseModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'address': address};
  }
}
