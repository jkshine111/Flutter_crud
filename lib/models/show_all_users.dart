// To parse this JSON data, do
//
//     final showAllUsers = showAllUsersFromJson(jsonString);

import 'dart:convert';

List<ShowAllUsers> showAllUsersFromJson(String str) => List<ShowAllUsers>.from(
    json.decode(str).map((x) => ShowAllUsers.fromJson(x)));

String showAllUsersToJson(List<ShowAllUsers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowAllUsers {
  ShowAllUsers({
    required this.contact,
    required this.id,
    required this.name,
  });

  String contact;
  int id;
  String name;

  factory ShowAllUsers.fromJson(Map<String, dynamic> json) => ShowAllUsers(
        contact: json["contact"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "contact": contact,
        "id": id,
        "name": name,
      };
  @override
  String toString() {
    // TODO: implement toString
    String result = name;
    return result;
  }
}
