// To parse this JSON data, do
//
//     final usersData = usersDataFromJson(jsonString);

import 'dart:convert';

UsersData usersDataFromJson(String str) => UsersData.fromJson(json.decode(str));

String usersDataToJson(UsersData data) => json.encode(data.toJson());

class UsersData {
  List<UserDetails>? data;

  UsersData({
    this.data,
  });

  UsersData copyWith({
    List<UserDetails>? data,
  }) =>
      UsersData(
        data: data ?? this.data,
      );

  factory UsersData.fromJson(Map<String, dynamic> json) => UsersData(
        data: json["data"] == null
            ? []
            : List<UserDetails>.from(
                json["data"]!.map((x) => UserDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UserDetails {
  int? id;
  String? name;
  int? age;
  List<UserDetails> child;

  UserDetails({
    this.id,
    this.name,
    this.age,
    this.child = const [],
  });

  UserDetails copyWith({
    int? id,
    String? name,
    int? age,
    List<UserDetails>? child,
  }) =>
      UserDetails(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age ?? this.age,
        child: child ?? this.child,
      );

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        child: json["child"] == null
            ? []
            : List<UserDetails>.from(
                json["child"]!.map((x) => UserDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "child": List<dynamic>.from(child!.map((x) => x.toJson())),
      };
}
