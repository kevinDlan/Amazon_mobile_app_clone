import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.address,
      required this.type,
      required this.token});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email':email,
      'password': password,
      'address': address,
      'type': type,
      'token': token
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
        id: json['_id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        address: json['address'] ?? '',
        type: json['type'],
        token: json['token']);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromJson(json.decode(source));
}
