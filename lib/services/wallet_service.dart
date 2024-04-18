import 'dart:convert';

import 'package:hex/hex.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_rootstock_wallet/util/CoinGeckoResponse.dart';
import 'package:my_rootstock_wallet/util/wei.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:sqflite/sqflite.dart';
import 'package:web3dart/credentials.dart';
import '../entities/wallet_entity.dart';
import '../util/util.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicKey(String privateKey);
}

class WalletServiceImpl extends ChangeNotifier implements WalletAddressService {
  static const PRIVATE_KEY = "flutter_k1";
  static const WALLET_NAME = "flutter_k2";
  static const PUBLIC_KEY = "flutter_k3";
  static const WID = "flutter_k4";

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.address;
    return address;
  }

  @override
  Future<String> getPublicKeyString(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.address;
    return address.hex;
  }

  Future<List<WalletEntity>> getWallets() async {

    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), DATABASE_NAME),
    );
    // Get a reference to the database.
    final db = await database;

    // Query the table for all the dogs.
    final List<Map<String, Object?>> walletMaps = await db.query('wallets');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {
      'privateKey': privateKey as String,
      'walletName': walletName as String,
      'walletId': walletId as String,
      'publicKey': publicKey as String,
      } in walletMaps)
        WalletEntity(privateKey: privateKey, publicKey: publicKey, walletId: walletId, walletName: walletName),
    ];
  }

  void persistNewWallet(WalletEntity wallet) async {
    print("Persisting");
    print(wallet);
    final db = await openDataBase();

    await db.insert(
      'wallets',
      wallet.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void delete(WalletEntity wallet) async {
    print("Deleting");
    print(wallet);
    final db = await openDataBase();
    await db.delete("wallets", where: 'privateKey = ?', whereArgs: [wallet.privateKey]);
  }

  Future<String> getBalance(WalletEntity wallet) async {
    const returnValue = "0.00";
    try {
      final client = Web3Client("http://192.168.15.6:4444", http.Client());
      final credentials = EthPrivateKey.fromHex(wallet.privateKey);
      final address = credentials.address;
      final balance = await client.getBalance(address);
      final wei = Wei(src: balance.getInWei, currency: "wei");
      return (wei.toRBTCTrimmedString());
    }catch(e){
      return returnValue;
    }
  }

  Future<int> getPrice() async {
    final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<CoinGeckoResponse> prices = body
          .map(
            (dynamic item) => CoinGeckoResponse.fromJson2(item),
      ).toList();
      var price = (prices.elementAt(0).current_price);

      setLastUsdPrice(price);

      return price;

    } else {
      return getLastUsdPrice();
    }
  }

}
