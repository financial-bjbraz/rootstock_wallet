import 'package:my_rootstock_wallet/cards/create_wallet_app.dart';
import 'package:my_rootstock_wallet/entities/simple_user.dart';
import 'package:my_rootstock_wallet/cards/account_info.dart';
import 'package:my_rootstock_wallet/cards/rewards.dart';
import 'package:my_rootstock_wallet/entities/wallet.dart';
import 'package:my_rootstock_wallet/pages/details/account_statements_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cards/card_app.dart';
import '../cards/import_seed_pk_app.dart';
import '../entities/wallet_entity.dart';
import '../services/wallet_service.dart';
import '../wallets/info/view_wallet.dart';
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
  late WalletServiceImpl walletService =
      Provider.of<WalletServiceImpl>(context);

  late Tween<double> _tween;
  final SimpleUser user;

  var widgets = <Widget>{};

  _PageViewAppState(this.user);

  @override
  void initState() {
    super.initState();
    _tween = Tween<double>(begin: 150.0, end: 0.0);
    //delayAnimation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadWallets();
  }

  loadWallets() async {
    var wallets = <WalletEntity>{};
    walletService.getWallets().then((walletsLoaded) => {
      print("Wallets Loaded"),
      print(walletsLoaded),
      for (final item in walletsLoaded) {
        print("getting a wallet"),
        widgets.add(CardApp(
          detailChild: ViewWalletDetail(),
          child: ViewWallet(wallet: item),
        )),
      }
    });
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
            child: GestureDetector(
              onPanUpdate: widget.onPanUpdated,
              child: PageView(
                onPageChanged: widget.onChanged,
                physics: widget.showMenu
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                children: <Widget>[
                  ...widgets,
                  const CreateWalletApp(),
                  const ImportSeedPkApp(),
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
