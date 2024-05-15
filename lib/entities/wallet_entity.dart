class WalletEntity{

  final String privateKey;
  final String walletName;
  final String walletId;
  final String publicKey;
  final String ownerEmail;

  WalletEntity({required this.privateKey, required this.walletName, required this.walletId, required this.publicKey, required this.ownerEmail});

  Map<String, Object?> toMap() {
    return {
      'privateKey': privateKey,
      'walletName': walletName,
      'walletId': walletId,
      'publicKey': publicKey,
      'ownerEmail': ownerEmail,
    };
  }

  @override
  String toString() {
    return 'WalletEntity{privateKey: $privateKey, walletName: $walletName, walletId: $walletId, publicKey: $publicKey ownerEmail: $ownerEmail}';
  }

}