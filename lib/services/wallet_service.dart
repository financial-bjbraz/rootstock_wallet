import 'dart:convert';

import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_rootstock_wallet/entities/wallet_dto.dart';
import 'package:my_rootstock_wallet/util/coingeck_resopnse.dart';
import 'package:my_rootstock_wallet/util/wei.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:web3dart/web3dart.dart';

import '../entities/wallet_entity.dart';
import '../util/util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  EthereumAddress getPublicKey(String privateKey);
}

class WalletServiceImpl extends ChangeNotifier implements WalletAddressService {
  static const privateKey = "flutter_k1";
  static const walletName = "flutter_k2";
  static const publickey = "flutter_k3";
  static const wid = "flutter_k4";

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
  EthereumAddress getPublicKey(String privateKey) {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = private.address;
    return address;
  }

  Future<String> getPublicKeyString(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = private.address;
    return address.hex;
  }

  Future<List<WalletEntity>> getWallets(final String ownerEmail) async {

    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), databaseName),
    );
    // Get a reference to the database.
    final db = await database;

    // Query the table for all the wallets.
    final List<Map<String, Object?>> walletMaps = await db.query('wallets', where: 'ownerEmail = ?', whereArgs: [ownerEmail]);

    // Convert the list of each fields into a list of `Wallet` objects.
    return [
      for (final {
        'privateKey': privateKey as String,
        'walletName': walletName as String,
        'walletId': walletId as String,
        'publicKey': publicKey as String,
        'ownerEmail': ownerEmail as String,
        'amount': amountValue as double,
        } in walletMaps)
        WalletEntity(amountValue, privateKey: privateKey, publicKey: publicKey, walletId: walletId, walletName: walletName, ownerEmail: ownerEmail),
    ];
  }

  void persistNewWallet(WalletEntity wallet) async {
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), databaseName),
    );
    // Get a reference to the database.
    final db = await database;

    await db.insert(
      'wallets',
      wallet.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    db.close();
  }

  void delete(WalletEntity wallet) async {
    final db = await openDataBase();
    await db.delete("wallets", where: 'privateKey = ?', whereArgs: [wallet.privateKey]);
  }

  Future<String> getBalance(WalletEntity wallet) async {
    const returnValue = "0.00";
    try {
      final wei = await getBalanceInWei(wallet);
      return (wei.toRBTCTrimmedString());
    }catch(e){
      return returnValue;
    }
  }

  Future<Wei> getBalanceInWei(WalletEntity wallet) async {
    var balance = EtherAmount.zero();
    try {
      final node = dotenv.env['ROOTSTOCK_NODE'];
      final client = Web3Client(node!, http.Client());
      final credentials = EthPrivateKey.fromHex(wallet.privateKey);
      final address = credentials.address;
      balance = await client.getBalance(address);
    } catch(error) {
      // error
    }
    return Wei(src: balance.getInWei, currency: "wei");
  }

  Future<WalletDTO> createWalletToDisplay(WalletEntity wallet) async {
    var walletDto = WalletDTO(wallet: wallet);
    final wei = await getBalanceInWei(wallet);
    final usdPrice = await getPrice();
    final value =  wei.getWei() * usdPrice;
    final formatter = NumberFormat.simpleCurrency();
    walletDto.amountInWeis = wei.getWei();
    walletDto.amountInUsd = value;
    walletDto.valueInWeiFormatted = (wei.toRBTCTrimmedStringPlaces(10));
    walletDto.valueInUsdFormatted = formatter.format(value);

    if(wei.src.compareTo(BigInt.from(wallet.amount)) != 0) {
      wallet.amount = wei.src.toDouble();
      persistNewWallet(wallet);
    }

    return walletDto;
  }

  Future<int> getPrice() async {
    final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<CoinGeckoResponse> prices = body
          .map(
            (dynamic item) => CoinGeckoResponse.fromJson2(item),
      ).toList();
      var price = (prices.elementAt(0).currentPrice);

      setLastUsdPrice(price);

      return price;

    } else {
      return getLastUsdPrice();
    }
  }

}
