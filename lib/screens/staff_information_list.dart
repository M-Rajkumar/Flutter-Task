// To parse this JSON data, do
//
//     final staffInfomation = staffInfomationFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class StaffInformationList {
  StaffInformationList({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.displayName,
    @required this.shortName,
    @required this.photo,
    @required this.logo,
    @required this.domain,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String displayName;
  final String shortName;
  final String photo;
  final String logo;
  final String domain;

  factory StaffInformationList.fromJson(String str) =>
      StaffInformationList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StaffInformationList.fromMap(Map<String, dynamic> json) =>
      StaffInformationList(
        id: json["id"] == null ? null : json["id"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        displayName: json["displayName"] == null ? null : json["displayName"],
        shortName: json["shortName"] == null ? null : json["shortName"],
        photo: json["photo"] == null ? null : json["photo"],
        logo: json["logo"] == null ? null : json["logo"],
        domain: json["domain"] == null ? null : json["domain"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "displayName": displayName == null ? null : displayName,
        "shortName": shortName == null ? null : shortName,
        "photo": photo == null ? null : photo,
        "logo": logo == null ? null : logo,
        "domain": domain == null ? null : domain,
      };
}
