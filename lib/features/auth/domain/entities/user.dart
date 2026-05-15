import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String name;
  final String email;
  final String hashedPassword;
  final String? createdAt;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.hashedPassword,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, email, hashedPassword, createdAt];
}
