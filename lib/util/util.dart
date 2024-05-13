import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_rootstock_wallet/entities/simple_user.dart';
import 'package:my_rootstock_wallet/entities/wallet_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DATABASE_NAME = "my_rootstock_wallet.db";

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
  var created = await prefs.getString("dataBaseCreated");
  return created != null;
}

Future<String> getIndex() async {
  var index = 0;
  final prefs = await SharedPreferences.getInstance();
  var indexStorage = await prefs.getString("index");

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
  final String? valor = await prefs.getString("lastBtcPrice");
  return int.parse(valor ?? "0");
}

Future<Database> openDataBase() async {
  if (kDebugMode) {
    print("====================================================================");
    print("==================== Opening database ==================");
  }
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  //  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  //
  Database database = await openDatabase(DATABASE_NAME, version: 1,
      onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE wallets(privateKey TEXT PRIMARY KEY, walletName TEXT, walletId TEXT,publicKey TEXT)'
      );
      await db.execute(
        'CREATE TABLE users(name TEXT PRIMARY KEY, email TEXT, userId TEXT, password TEXT)'
      );
    });

  if (kDebugMode) {
    print("====================================================================");
    print("==========Creating database =============");
  }

  return database;
}

createTable() async {
  openDataBase();
}

InputDecoration simmpleDecoration(final String labelText, final Icon icon) {
  FocusNode textSecondFocusNode = FocusNode();
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

