import 'dart:convert';

class UserModel {
  String uid;
  String name;
  String email;
  String position;
  String phone;
  String image;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.position,
    required this.phone,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'position': position,
      'phone': phone,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      position: map['position'],
      phone: map['phone'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
