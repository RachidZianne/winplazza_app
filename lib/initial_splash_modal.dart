import 'dart:convert';

class InitialSplashModal {
  String? status;
  List<Datum>? data;

  InitialSplashModal({
    this.status,
    this.data,
  });

  factory InitialSplashModal.fromJson(String str) => InitialSplashModal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InitialSplashModal.fromMap(Map<String, dynamic> json) => InitialSplashModal(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  int? id;
  String? key;
  String? value;
  String? type;
  dynamic createdBy;
  int? updatedBy;
  dynamic createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.key,
    this.value,
    this.type,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    key: json["key"],
    value: json["value"],
    type: json["type"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "key": key,
    "value": value,
    "type": type,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
  };
}
