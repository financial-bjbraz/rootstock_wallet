import 'package:my_rootstock_wallet/entities/simple_transaction.dart';
import 'package:my_rootstock_wallet/entities/wallet_entity.dart';

import '../util/util.dart';

class WalletDTO {

  late String? publicKey;
  final WalletEntity wallet;
  late double amountInUsd;
  late double amountInWeis;
  late String valueInUsdFormatted;
  late String valueInWeiFormatted;
  Set<SimpleTransaction>? transactions;

  WalletDTO({required this.wallet, required this.transactions});

  String getName() {
    return "Wallet #${wallet.walletId}";
  }

  String getPrivateKeyToDisplay() {
    return "";
  }

  String getAddress() {
    return formatAddress(wallet.publicKey);
  }

  String getCompleteAddress() {
    return wallet.publicKey;
  }

  String getValueInUsd(){
    return valueInUsdFormatted;
  }

}
