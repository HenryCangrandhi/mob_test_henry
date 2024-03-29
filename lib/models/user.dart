
import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final String name;
  final String address;
  final String email;
  final String phoneNumber;
  final String city;
  final String id;

  User({
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    address: json["address"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    city: json["city"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "email": email,
    "phoneNumber": phoneNumber,
    "city": city,
    "id": id,
  };
}
