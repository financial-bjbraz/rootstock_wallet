class WalletEntity{

  final String privateKey;
  final String walletName;
  final String walletId;
  final String publicKey;

  WalletEntity({required this.privateKey, required this.walletName, required this.walletId, required this.publicKey});

  Map<String, Object?> toMap() {
    return {
      'privateKey': privateKey,
      'walletName': walletName,
      'walletId': walletId,
      'publicKey': publicKey,
    };
  }

  @override
  String toString() {
    return 'WalletEntity{privateKey: $privateKey, walletName: $walletName, walletId: $walletId, publicKey: $publicKey}';
  }

}