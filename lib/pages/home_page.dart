import 'package:my_rootstock_wallet/entities/simple_user.dart';
import 'package:my_rootstock_wallet/pages/bottom_menu.dart';
import 'package:my_rootstock_wallet/pages/menu_app.dart';
import 'package:my_rootstock_wallet/pages/my_app_bar.dart';
import 'package:my_rootstock_wallet/pages/my_dots_app.dart';
import 'package:my_rootstock_wallet/pages/page_view_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entities/wallet_entity.dart';
import '../services/wallet_service.dart';

class HomePage extends StatefulWidget {
  final SimpleUser user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  late bool _showMenu;
  late int _currentIndex;
  late double _yPosition = 0;
  late SimpleUser _user;
  late int _walletQuantity;
  late WalletServiceImpl walletService = Provider.of<WalletServiceImpl>(context);

  _HomePageState(this._user);

  @override
  void initState() {
    super.initState();
    _showMenu = false;
    _currentIndex = 0;
    _walletQuantity = 0;
  }

  loadWallets() async {
    walletService.getWallets().then((walletsLoaded) => {
      print("Wallets Loaded"),
      print(walletsLoaded),
      setState(() {
         _walletQuantity = walletsLoaded.length;
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    loadWallets();
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
          PageViewApp(
            user: _user,
            showMenu: _showMenu,
            top: _yPosition,
            onChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            onPanUpdated: (details) {
              double positionBottonLimit = _heightScreen * .75;
              double positionTopLimit = _heightScreen * .24;
              double middlePosition = positionBottonLimit - positionTopLimit;
              middlePosition = middlePosition / 2;

              setState(() {
                _yPosition += details.delta.dy;

                _yPosition = _yPosition < positionTopLimit
                    ? positionTopLimit
                    : _yPosition;

                _yPosition = _yPosition > positionBottonLimit
                    ? positionBottonLimit
                    : _yPosition;

                if (_yPosition != positionBottonLimit && details.delta.dy > 0) {
                  _yPosition =
                      _yPosition > positionTopLimit + middlePosition - 50
                          ? positionBottonLimit
                          : _yPosition;
                }

                if (_yPosition != positionTopLimit && details.delta.dy < 0) {
                  _yPosition = _yPosition < positionBottonLimit - middlePosition
                      ? positionTopLimit
                      : _yPosition;
                }

                if (_yPosition == positionBottonLimit) {
                  _showMenu = true;
                } else if (_yPosition == positionTopLimit) {
                  _showMenu = false;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
