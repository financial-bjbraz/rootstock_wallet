import 'dart:ffi';

class WalletDTO {

  late String? privateKey;
  late String? walletName;
  late String? walletId;
  late String? publicKey;

  bool created = false;

  WalletDTO() {
    privateKey = "";
    walletName = "";
    walletId = "";
  }

  WalletDTO.n() : privateKey = "", walletName = "", walletId = "";

  //WalletEntity({required this.privateKey, required this.walletName, required this.walletId});

}
