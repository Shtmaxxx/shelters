import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
  });

  final String id;
  final String name;
  final String email;
  final bool isAdmin;

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    bool? isAdmin,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  List<Object?> get props => [id, email, name, isAdmin];
}
