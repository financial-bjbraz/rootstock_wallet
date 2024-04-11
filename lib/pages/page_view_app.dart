import 'package:my_rootstock_wallet/cards/create_wallet_app.dart';
import 'package:my_rootstock_wallet/entities/simple_user.dart';
import 'package:my_rootstock_wallet/cards/account_info.dart';
import 'package:my_rootstock_wallet/cards/rewards.dart';
import 'package:my_rootstock_wallet/entities/wallet.dart';
import 'package:my_rootstock_wallet/pages/details/account_statements_detail.dart';
import 'package:flutter/material.dart';
import 'package:my_rootstock_wallet/wallets/create_import/import_wallet_detail.dart';
import 'package:my_rootstock_wallet/wallets/create_import/import_wallet.dart';
import '../cards/card_app.dart';
import '../wallets/create_import/create_wallet.dart';
import '../wallets/info/view_wallet.dart';
import '../wallets/create_import/create_wallet_detail.dart';
import '../wallets/info/view_wallet_detail.dart';

class PageViewApp extends StatefulWidget {
  final double top;
  final ValueChanged<int> onChanged;
  final GestureDragUpdateCallback onPanUpdated;
  final bool showMenu;
  final SimpleUser user;

  const PageViewApp(
      {Key? key,
      required this.top,
      required this.onChanged,
      required this.onPanUpdated,
      required this.showMenu,
      required this.user})
      : super(key: key);

  @override
  _PageViewAppState createState() => _PageViewAppState(user);
}

class _PageViewAppState extends State<PageViewApp> {
  late Tween<double> _tween;
  final SimpleUser user;
  final Wallet wallet = Wallet.n();

  _PageViewAppState(this.user);

  @override
  void initState() {
    super.initState();
    _tween = Tween<double>(begin: 150.0, end: 0.0);

    //delayAnimation();
  }

  Future<void> delayAnimation() async {
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        _tween = Tween<double>(begin: 150.0, end: 0.0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: _tween,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutExpo,
        builder: (context, value, child) {
          return AnimatedPositioned(
            duration: const Duration(microseconds: 250),
            curve: Curves.easeOut,
            left: value,
            right: value * -1,
            top: widget.top,
            height: MediaQuery.of(context).size.height * .45,
            //width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onPanUpdate: widget.onPanUpdated,
              child: PageView(
                onPageChanged: widget.onChanged,
                physics: widget.showMenu
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                children: <Widget>[
                  CardApp(
                    detailChild: ViewWalletDetail(),
                    child: ViewWallet(wallet: wallet),
                  ),
                  const CreateWalletApp( ),
                  CardApp(
                    detailChild:ImportNewWalletDetail(),
                    child:ImportWallet(wallet: wallet) ,
                  ),
                  CardApp(
                    detailChild: AccountStatementsDetail(),
                    child: const AccountInfo(),
                  ),
                  const CardApp(
                    detailChild: AccountInfo(),
                    child: Rewards(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
