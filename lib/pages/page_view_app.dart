import 'package:my_rootstock_wallet/entities/simple_user.dart';
import 'package:my_rootstock_wallet/cards/account_info.dart';
import 'package:my_rootstock_wallet/cards/credit_card.dart';
import 'package:my_rootstock_wallet/cards/rewards.dart';
import 'package:my_rootstock_wallet/pages/details/account_statements_detail.dart';
import 'package:my_rootstock_wallet/pages/details/card_statements_detail.dart';
import 'package:flutter/material.dart';

import '../cards/card_app.dart';

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

  _PageViewAppState(this.user);

  @override
  void initState() {
    super.initState();
    _tween = Tween<double>(begin: 150.0, end: 0.0);

    ///delayAnimation();
  }

  Future<void> delayAnimation() async {
    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        _tween = Tween<double>(begin: 150.0, end: 0.0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: _tween,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutExpo,
        builder: (context, value, child) {
          return AnimatedPositioned(
            duration: Duration(microseconds: 250),
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
                    ? NeverScrollableScrollPhysics()
                    : BouncingScrollPhysics(),
                children: <Widget>[
                  CardApp(
                    child: CreditCard(),
                    detailChild: CardStatementsDetail(),
                  ),
                  CardApp(
                    child: AccountInfo(),
                    detailChild: AccountStatementsDetail(),
                  ),
                  CardApp(
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
