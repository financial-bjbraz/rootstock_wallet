import 'package:my_rootstock_wallet/entities/wallet_entity.dart';

import '../util/util.dart';

class WalletDTO {

  late String? publicKey;
  final WalletEntity wallet;
  late double amountInUsd;
  late double amountInWeis;
  late String valueInUsdFormatted;
  late String valueInWeiFormatted;

  WalletDTO({required this.wallet});

  String getName() {
    return "Wallet #${wallet.walletId}";
  }

  String getPrivateKeyToDisplay() {
    return "";
  }

  String getAddress() {
    return formatAddress(wallet.publicKey);
  }

  String getValueInUsd(){
    return valueInUsdFormatted;
  }

}
