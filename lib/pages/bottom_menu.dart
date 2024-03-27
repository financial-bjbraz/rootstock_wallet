import 'package:my_rootstock_wallet/pages/item_menu_botton.dart';
import 'package:my_rootstock_wallet/pages/details/account_statements_detail.dart';
import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  final bool showMenu;
  const BottomMenu({Key? key, required this.showMenu}) : super(key: key);
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  late Tween<double> _tween;

  @override
  void initState() {
    super.initState();
    _tween = Tween<double>(begin: 150.0, end: 0.0);
    //delayAnimation();
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
        duration: Duration(milliseconds: 350),
        curve: Curves.easeOutExpo,
        builder: (context, value, child) {
          return AnimatedPositioned(
            duration: Duration(milliseconds: 350),
            bottom: !widget.showMenu
                ? 0 + MediaQuery.of(context).padding.bottom
                : 0,
            left: value,
            right: value * -1,
            height: MediaQuery.of(context).size.height * 0.14,
            child: IgnorePointer(
              ignoring: widget.showMenu,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: !widget.showMenu ? 1 : 0,
                child: Container(
                  color: Color(0x293145),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ItemMenuBottom(
                        icon: Icons.person_add,
                        text: "indicar amigos",
                        widget: AccountStatementsDetail(),
                      ),
                      ItemMenuBottom(
                        icon: Icons.phone_android,
                        text: "Recarga de celular",
                        widget: AccountStatementsDetail(),
                      ),
                      ItemMenuBottom(
                        icon: Icons.chat,
                        text: "Cobrar",
                        widget: AccountStatementsDetail(),
                      ),
                      ItemMenuBottom(
                        icon: Icons.monetization_on,
                        text: "Empréstimos",
                        widget: AccountStatementsDetail(),
                      ),
                      ItemMenuBottom(
                        icon: Icons.move_to_inbox,
                        text: "Depositar",
                        widget: AccountStatementsDetail(),
                      ),
                      ItemMenuBottom(
                        icon: Icons.mobile_screen_share,
                        text: "Transferir",
                        widget: AccountStatementsDetail(),
                      ),
                      ItemMenuBottom(
                        icon: Icons.format_align_center,
                        text: "Ajustar limite",
                        widget: AccountStatementsDetail(),
                      ),
                      ItemMenuBottom(
                        icon: Icons.chrome_reader_mode,
                        text: "Pagar",
                        widget: AccountStatementsDetail(),
                      ),
                      ItemMenuBottom(
                        icon: Icons.lock_open,
                        text: "Bloquear",
                        widget: AccountStatementsDetail(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
