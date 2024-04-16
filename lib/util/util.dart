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

final ButtonStyle greenButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(88, 36),
  backgroundColor: const Color.fromRGBO(121, 198, 0, 1),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

final ButtonStyle pingButton = ElevatedButton.styleFrom(
  minimumSize: const Size(88, 36),
  backgroundColor: const Color.fromRGBO(121, 198, 0, 1),
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
  print("The table is created ? ${created}" );
  return created != null;
}

setDataBaseCreated() async {
   final prefs = await SharedPreferences.getInstance();
   await prefs.setString("dataBaseCreated", "true");
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
final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), DATABASE_NAME),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE wallets(privateKey TEXT PRIMARY KEY, walletName TEXT, walletId TEXT,publicKey TEXT)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
  if (kDebugMode) {
    print("====================================================================");
    print("==========Creating database =============");
  }

  return database;
}

createTable() async {
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
      join(await getDatabasesPath(), DATABASE_NAME),
  // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
  // Run the CREATE TABLE statement on the database.
  return db.execute(
  'CREATE TABLE wallets(privateKey TEXT PRIMARY KEY, walletName TEXT, walletId TEXT,publicKey TEXT)',
  );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
  );
  print("=========table wallets created======");
}

Future<dynamic> closeBoxes() async {
  print("====================================================================");

  print("====================================================================");
}

String getAddress(WalletEntity wallet) {
  var address = wallet.publicKey;
  address = "${address.substring(0, 8)}...${address.substring(
      address.length - 8, address.length)}";
  return address;
}