

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserService {
  late User firebaseUser;
  final databaseReference = FirebaseDatabase.instance.ref();


}