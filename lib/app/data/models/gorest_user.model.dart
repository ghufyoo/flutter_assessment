// To parse this JSON data, do
//
//     final goRestUserModel = goRestUserModelFromJson(jsonString);

import 'dart:convert';

List<GoRestUserModel> goRestUserModelFromJson(String str) => List<GoRestUserModel>.from(json.decode(str).map((x) => GoRestUserModel.fromJson(x)));

String goRestUserModelToJson(List<GoRestUserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GoRestUserModel {
    int id;
    String name;
    String email;
    Gender gender;
    Status status;

    GoRestUserModel({
        required this.id,
        required this.name,
        required this.email,
        required this.gender,
        required this.status,
    });

    factory GoRestUserModel.fromJson(Map<String, dynamic> json) => GoRestUserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        gender: genderValues.map[json["gender"]]!,
        status: statusValues.map[json["status"]]!,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "gender": genderValues.reverse[gender],
        "status": statusValues.reverse[status],
    };
}

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({
    "female": Gender.FEMALE,
    "male": Gender.MALE
});

enum Status { INACTIVE, ACTIVE }

final statusValues = EnumValues({
    "active": Status.ACTIVE,
    "inactive": Status.INACTIVE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
