
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SimpleUser {
  late String name;
  late String email;
  late String userId;

  SimpleUser({required this.name, required this.email});

}
