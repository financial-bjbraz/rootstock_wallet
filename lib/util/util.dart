import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

const databaseName = "my_rootstock_wallet.db";

orange() => const Color.fromRGBO(255, 145, 0, 1);
pink() => const Color.fromRGBO(255, 112, 224, 1);
green() => const Color.fromRGBO(121, 198, 0, 1);
lightBlue() => const Color.fromRGBO(8, 255, 208, 1);
purple() => const Color.fromRGBO(158, 118, 255, 1);
yellow() => const Color.fromRGBO(222, 255, 26, 1);

void showMessage(String message, BuildContext context) {
  final snackBar = SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {},
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

final ButtonStyle orangeButton = ElevatedButton.styleFrom(
  minimumSize: const Size(88, 36),
  backgroundColor: const Color.fromRGBO(255, 145, 0, 1),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

final ButtonStyle yellowButton = ElevatedButton.styleFrom(
  minimumSize: const Size(88, 36),
  backgroundColor: yellow(),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

final ButtonStyle lightBlueButton = ElevatedButton.styleFrom(
  minimumSize: const Size(88, 36),
  backgroundColor: lightBlue(),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

final ButtonStyle greenButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(88, 36),
  backgroundColor: const Color.fromRGBO(121, 198, 0, 1),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

final ButtonStyle pinkButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(88, 36),
  backgroundColor: pink(),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

Future<void> delay(BuildContext context, int seconds) {
  return Future.delayed(Duration(seconds: seconds), () {});
}

verifyAndCreateDataBase() async {
  var created = await isTableCreated();

  openDataBase();

  if(!created) {
    createTable();
  }
}

Future<bool> isTableCreated() async {
  final prefs = await SharedPreferences.getInstance();
  var created = prefs.getString("dataBaseCreated_2");
  return created != null;
}

Future<String> getIndex() async {
  var index = 0;
  final prefs = await SharedPreferences.getInstance();
  var indexStorage = prefs.getString("index");

  if(indexStorage != null) {
    index = int.parse(indexStorage);
    indexStorage = (index + 1).toString();
  } else {
    indexStorage = "0";
  }

  await prefs.setString("index", indexStorage);

  return index.toString();
}

setDataBaseCreated() async {
   final prefs = await SharedPreferences.getInstance();
   await prefs.setString("dataBaseCreated", "true");
}

setLastUsdPrice(int price) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("lastBtcPrice", price.toString());
}

Future<int> getLastUsdPrice() async {
  final prefs = await SharedPreferences.getInstance();
  final String? valor = prefs.getString("lastBtcPrice");
  return int.parse(valor ?? "0");
}

Future<Database> openDataBase() async {
  if (kDebugMode) {
    print("====================================================================");
    print("==================== Opening database ==================");
  }

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, databaseName);
  Database database = await openDatabase(path, version: 3,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE wallets(privateKey TEXT PRIMARY KEY, walletName TEXT, walletId TEXT,publicKey TEXT, ownerEmail TEXT)',
          );
          if (kDebugMode) {
            print("creating table users ");
          }
          await db.execute(
            'CREATE TABLE users(name TEXT PRIMARY KEY, email TEXT, userId TEXT, password TEXT)',
          );
          if (kDebugMode) {
            print("created table users ");
          }
        });
  try {
    database.transaction((txn) async {
      await txn.execute(
          "CREATE TABLE wallets(privateKey TEXT PRIMARY KEY, walletName TEXT, walletId TEXT,publicKey TEXT, ownerEmail TEXT);");
    });
    database.transaction((txn) async {
      await txn.execute(
          "CREATE TABLE users(name TEXT PRIMARY KEY, email TEXT, userId TEXT, password TEXT)");
    });
  } catch(e){
    if (kDebugMode) {
      print("Error occurred");
    }
  }

  if (kDebugMode) {
    print("====================================================================");
    print("==========Database opened  =============");
  }

  return database;
}


createTable() async {
  openDataBase();
}

InputDecoration simmpleDecoration(final String labelText, final Icon icon) {
  return InputDecoration(
      focusColor: Colors.white,
      enabled: true,

      fillColor: Colors.white,
      prefixIcon: icon,
      labelText: labelText,
      labelStyle: const TextStyle( color: Colors.white ),
      enabledBorder: const OutlineInputBorder(
        borderSide:
        BorderSide(color: Colors.white),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide:
        BorderSide(width: 2, color: Colors.white),
      ),
      border: const OutlineInputBorder(
        borderSide:
        BorderSide(width: 1, color: Colors.white),
      ),
      suffixIcon: IconButton(
        icon: const Icon(Icons.done, color: Colors.white,),
        splashColor: Colors.green,
        tooltip: "Submit",
        onPressed: () {

        },
      ));
}
