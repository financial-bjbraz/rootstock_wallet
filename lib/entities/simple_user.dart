
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SimpleUser {
  late String name;
  late String email;
  late String userId;

  late String mobileNumber;
  late String cpf;
  late String address;
  late String address1;
  late String address2;
  late String state;
  late String city;
  late String neighborhood;
  late String photo;
  late String geolocalization;

  SimpleUser({required this.name, required this.email});

  SimpleUser.recovered(
      {required this.name,
        required this.email,
        mobileNumber,
        userId,
        cpf,
        address,
        address1,
        state,
        city,
        neighborhood,
        photo,
        geolocalization});

  SimpleUser.n(User firebaseUser) {
    name = firebaseUser.displayName!;
    email = firebaseUser.email!;
    userId = firebaseUser.uid;

    mobileNumber = "(11) 97513-2627";
    cpf = "22387750803";
    address = "address 1";
    address1 = "address complement";
    address2 = "other complement";
    state = "SP";
    city = "São Paulo";
    neighborhood = "JD Santa Izabel";
    photo = "a photo";
    geolocalization = " a geo";
  }



}
