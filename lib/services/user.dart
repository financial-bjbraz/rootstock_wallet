

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_rootstock_wallet/entities/simple_user.dart';

class UserService {
  late User firebaseUser;
  final databaseReference = FirebaseDatabase.instance.ref();


}