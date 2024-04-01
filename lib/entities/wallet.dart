import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class Wallet {
  late String? privateKey;
  late String? walletName;
  late String? walletId;
  bool created = false;

  static const pKEY = "WALLET_DATA";
  static const wNAME = "WALLET_NAME";
  static const wID = "WALLET_ID";

  Wallet({required this.privateKey, required this.walletName, required this.walletId});
  Wallet.n() {
    retrieveFromDisk();
  }

  Future<void> saveOnDisk() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(pKEY, privateKey!);
    await prefs.setString(wNAME, walletName!);
    await prefs.setString(wID, walletId!);
  }

  Future<void> retrieveFromDisk() async {
    final prefs = await SharedPreferences.getInstance();
    privateKey = (prefs.getString(pKEY));
    walletName = (prefs.getString(wNAME));
    walletId   = (prefs.getString(wID));
    created    = walletId != null;
  }

}
