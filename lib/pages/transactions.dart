import 'package:flutter/material.dart';
import 'package:my_rootstock_wallet/entities/simple_user.dart';
import 'package:my_rootstock_wallet/pages/bottom_menu.dart';
import 'package:my_rootstock_wallet/pages/menu_app.dart';
import 'package:my_rootstock_wallet/pages/my_app_bar.dart';
import 'package:my_rootstock_wallet/pages/my_dots_app.dart';

class TransactionsPage extends StatefulWidget {
  final SimpleUser user;

  const TransactionsPage({super.key, required this.user});

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late bool _showMenu;
  late int _currentIndex;
  late final int _walletQuantity = 0;
  late double _yPosition = 0;

  _TransactionsPageState();

  @override
  void initState() {
    super.initState();
    _showMenu = false;
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    if (_yPosition == 0) {
      _yPosition = heightScreen * .24;
    }
    return Scaffold(
      backgroundColor: const Color(0x00293145),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          MyAppBar(
            showMenu: _showMenu,
            userName: widget.user.name,
            onTap: () {
              setState(() {
                _showMenu = !_showMenu;
                _yPosition =
                _showMenu ? heightScreen * .75 : heightScreen * .24;
              });
            },
          ),
          MenuApp(
            top: heightScreen * .205,
            showMenu: _showMenu,
          ),
          BottomMenu(
            showMenu: _showMenu,
          ),
          MyDotsApp(
              showMenu: _showMenu,
              top: heightScreen * .70,
              currentIndex: _currentIndex,
              walletQuantity: _walletQuantity,
          ),
        ],
      ),
    );
  }
}
