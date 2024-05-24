import 'dart:convert' as dart_convert;

import 'package:equatable/equatable.dart';

String encodeUserToString(User user) => dart_convert.json.encode(user.toJson());

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
    required this.isTermsAccepted,
    required this.phone,
  });

  final int id;
  final String? email;
  final String? name;
  final String phone;
  final bool isTermsAccepted;

  @override
  String toString() {
    return 'User: { '
        'id: $id, '
        'email: $email, '
        '}';
  }

  User copyWith({
    int? id,
    String? email,
    String? name,
    String? phone,
    bool? isTermsAccepted,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
    );
  }

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) throw (Exception('user_from_json_error'));

    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      isTermsAccepted: json['is_terms_accepted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'is_terms_accepted': isTermsAccepted,
    };
  }

  @override
  List<Object?> get props => [id, email, name, isTermsAccepted, phone];
}
