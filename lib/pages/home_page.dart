import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_rootstock_wallet/entities/simple_user.dart';
import 'package:my_rootstock_wallet/pages/menu_app.dart';
import 'package:my_rootstock_wallet/pages/my_app_bar.dart';
import 'package:my_rootstock_wallet/pages/my_dots_app.dart';
import 'package:my_rootstock_wallet/pages/page_view_app.dart';
import 'package:my_rootstock_wallet/util/util.dart';
import 'package:provider/provider.dart';

import '../services/wallet_service.dart';
import 'details/create_send_transaction.dart';
import 'details/detail_list.dart';

class HomePage extends StatefulWidget {
  final SimpleUser user;

  const HomePage({super.key, required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _showMenu;
  late int _currentIndex;
  late double _yPosition = 0;
  late int _walletQuantity;
  late WalletServiceImpl walletService =
      Provider.of<WalletServiceImpl>(context);

  _HomePageState();

  @override
  void initState() {
    super.initState();
    _showMenu = false;
    _currentIndex = 0;
    _walletQuantity = 0;
  }

  loadWallets() async {
    try {
      walletService.getWallets(widget.user.email).then((walletsLoaded) =>
      {
        setState(() {
          _walletQuantity = walletsLoaded.length;
        }),
      });
    }catch(e) {
      // print('error occurred $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    loadWallets();
    double heightScreen = MediaQuery.of(context).size.height;

    if (_yPosition == 0) {
      _yPosition = heightScreen * .24;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar:
          CurvedNavigationBar(color: orange(), backgroundColor: Colors.black, buttonBackgroundColor: orange(), items: [
            const Icon(Icons.home, color: Colors.white),
            _walletQuantity > 0 ? GestureDetector(
          child: const Icon(Icons.call_made, color: Colors.white),
          onTap: () => {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  DetailList(child: CreateSendTransaction(user: widget.user,)),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = const Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ))
          },
        ) : const SizedBox(),

            _walletQuantity > 0 ? const Icon(Icons.call_received, color: Colors.white) : const SizedBox(),
      ]),
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
          // BottomMenu(
          //   showMenu: _showMenu,
          // ),
          MyDotsApp(
            showMenu: _showMenu,
            top: heightScreen * .70,
            currentIndex: _currentIndex,
            walletQuantity: _walletQuantity,
          ),
          PageViewApp(
            user: widget.user,
            showMenu: _showMenu,
            top: _yPosition,
            onChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            onPanUpdated: (details) {
              double positionBottonLimit = heightScreen * .75;
              double positionTopLimit = heightScreen * .24;
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
