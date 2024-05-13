
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SimpleUser {
  late String name;
  late String email;
  late String userId;
  late String password;

  SimpleUser({required this.name, required this.email, required this.password});

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'email': email,
      'userId': userId,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'SimpleUser{name: $name, email: $email, userId: $userId, password: $password}';
  }

}
