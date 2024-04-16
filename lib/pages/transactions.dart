import 'package:my_rootstock_wallet/entities/simple_user.dart';
import 'package:my_rootstock_wallet/pages/bottom_menu.dart';
import 'package:my_rootstock_wallet/pages/menu_app.dart';
import 'package:my_rootstock_wallet/pages/my_app_bar.dart';
import 'package:my_rootstock_wallet/pages/my_dots_app.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  final SimpleUser user;

  const TransactionsPage({Key? key, required this.user}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState(user);
}

class _TransactionsPageState extends State<TransactionsPage> {
  late bool _showMenu;
  late int _currentIndex;
  late int _walletQuantity = 0;
  late double _yPosition = 0;
  late final SimpleUser _user;

  _TransactionsPageState(this._user);

  @override
  void initState() {
    super.initState();
    _showMenu = false;
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _heightScreen = MediaQuery.of(context).size.height;

    if (_yPosition == 0) {
      _yPosition = _heightScreen * .24;
    }
    return Scaffold(
      backgroundColor: Color(0x293145),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          MyAppBar(
            showMenu: _showMenu,
            userName: _user.name,
            onTap: () {
              setState(() {
                _showMenu = !_showMenu;
                _yPosition =
                _showMenu ? _heightScreen * .75 : _heightScreen * .24;
              });
            },
          ),
          MenuApp(
            top: _heightScreen * .205,
            showMenu: _showMenu,
          ),
          BottomMenu(
            showMenu: _showMenu,
          ),
          MyDotsApp(
              showMenu: _showMenu,
              top: _heightScreen * .70,
              currentIndex: _currentIndex,
              walletQuantity: _walletQuantity,
          ),
        ],
      ),
    );
  }
}
