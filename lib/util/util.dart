import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_rootstock_wallet/entities/simple_user.dart';

import '../entities/wallet_entity.dart';

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

Future<dynamic> initializaBoxes() async {
  await Hive.initFlutter();
  await Hive.openBox<WalletEntity>('wallets');
  await Hive.openBox<SimpleUser>('users');
}