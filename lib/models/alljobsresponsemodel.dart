import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

AllJobsResponesModel allJobsResponesModelFromJson(String str) =>
    AllJobsResponesModel.fromJson(json.decode(str));

String allJobsResponesModelToJson(AllJobsResponesModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AllJobsResponesModel {
  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;
  AllJobsResponesModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory AllJobsResponesModel.fromJson(Map<String, dynamic> json) {
    // var resultJson = json["results"] as List;
    // List<Result> resultList =
    //     resultJson.map((x) => Result.fromJson(x)).toList();
    return AllJobsResponesModel(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as dynamic,
      results:
          List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  int? id;
  bool courtesyJob;
  Type type;
  String description;
  String? issueType;
  String? category;
  String? property;
  String status;
  Stage stage;
  RequestType requestType;
  String? unit;
  String? priority;
  String? serviceType;
  Source source;
  RequestedBy requestedBy;
  Result({
    this.id,
    required this.courtesyJob,
    required this.type,
    required this.description,
    this.issueType,
    this.category,
    this.property,
    required this.status,
    required this.stage,
    required this.requestType,
    this.unit,
    this.priority,
    this.serviceType,
    required this.source,
    required this.requestedBy,
  });
  factory Result.fromJson(Map<String, dynamic> json) {
    // var stateList = json["stage"] as List;
    // List<Stage> stageList = stateList.map((x) => Stage.fromJson(x)).toList();
    //print(stageList);
    return Result(
      id: json["id"],
      courtesyJob: json["courtesy_job"],
      type: typeValues.map[json["type"]]!,
      description: json["description"],
      issueType: json["issue_type"],
      category: json["category"],
      property: json["property"],
      status: json["status"],
      stage: Stage.fromJson(json["stage"]),
      requestType: requestTypeValues.map[json["request_type"]]!,
      unit: json["unit"],
      priority: json["priority"],
      serviceType: json["service_type"],
      source: sourceValues.map[json["source"]]!,
      requestedBy: requestedByValues.map[json["requested_by"]]!,
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "courtesy_job": courtesyJob,
        "type": typeValues.reverse[type],
        "description": description,
        "issue_type": issueType,
        "category": category,
        "property": property,
        "status": status,
        "stage": stage.toJson(),
        "request_type": requestTypeValues.reverse[requestType],
        "unit": unit,
        "priority": priority,
        "service_type": serviceType,
        "source": sourceValues.reverse[source],
        "requested_by": requestedByValues.reverse[requestedBy],
      };
}

class Stage {
  Stage({
    required this.id,
    this.name,
  });

  String id;
  String? name;

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

enum Name { TO_DO, CLOSED }

final nameValues = EnumValues({"Closed": Name.CLOSED, "To Do": Name.TO_DO});

enum Priority { MEDIUM }

final priorityValues = EnumValues({"Medium": Priority.MEDIUM});

enum Property { THIN_Q24 }

final propertyValues = EnumValues({"thinQ24": Property.THIN_Q24});

enum RequestType { IN_UNIT }

final requestTypeValues = EnumValues({"In Unit": RequestType.IN_UNIT});

enum RequestedBy { MANAGER, ENGINEER, OWNER, TENANT }

final requestedByValues = EnumValues({
  "Engineer": RequestedBy.ENGINEER,
  "Manager": RequestedBy.MANAGER,
  "Owner": RequestedBy.OWNER,
  "Tenant": RequestedBy.TENANT
});

enum ServiceType { SERVICE, OTHER, INSPECTION }

final serviceTypeValues = EnumValues({
  "Inspection": ServiceType.INSPECTION,
  "Other": ServiceType.OTHER,
  "Service": ServiceType.SERVICE
});

enum Source { IN_SYSTEM, SERVICE_PLANNER, INBOX, SERVICE_FORM }

final sourceValues = EnumValues({
  "Inbox": Source.INBOX,
  "In System": Source.IN_SYSTEM,
  "Service Form": Source.SERVICE_FORM,
  "Service Planner": Source.SERVICE_PLANNER
});

enum Type { REGULAR }

final typeValues = EnumValues({"Regular": Type.REGULAR});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
