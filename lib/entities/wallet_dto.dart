import 'package:my_rootstock_wallet/entities/wallet_entity.dart';

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
    var address = wallet.publicKey;
    address = "${address.substring(0, 8)}...${address.substring(
        address.length - 8, address.length)}";
    return address;
  }

  String getValueInUsd(){
    return valueInUsdFormatted;
  }

}
