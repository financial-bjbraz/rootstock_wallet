import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_rootstock_wallet/entities/wallet.dart';
import 'package:my_rootstock_wallet/wallets/create_import_wallets.dart';
import 'package:my_rootstock_wallet/wallets/wallet_info.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key, required this.wallet});

  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: const Column(
            children:  [
              if (false) CreateImportWallets(),
              if (true) WalletInfo()
            ],
          ),
    );
  }

}
