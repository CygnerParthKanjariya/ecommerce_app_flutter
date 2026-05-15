import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    int? id,
    required String name,
    required String email,
    required String hashedPassword,
    String? createdAt,
  }) : super(
          id: id,
          name: name,
          email: email,
          hashedPassword: hashedPassword,
          createdAt: createdAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      hashedPassword: json['hashedPassword'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'hashedPassword': hashedPassword,
      'createdAt': createdAt ?? DateTime.now().toIso8601String(),
    };
  }
}
