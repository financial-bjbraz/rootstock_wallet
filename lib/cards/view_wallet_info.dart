import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_rootstock_wallet/entities/wallet_dto.dart';
import 'package:my_rootstock_wallet/pages/details/detail_list.dart';
import 'package:my_rootstock_wallet/wallets/info/view_wallet_detail.dart';
import 'package:provider/provider.dart';
import '../../entities/simple_user.dart';
import '../../pages/home_page.dart';
import '../../services/wallet_service.dart';
import '../entities/wallet_entity.dart';
import '../util/util.dart';
import 'widget_shimmer.dart';
import 'shimmer_loading.dart';

class ViewWalletInfo extends StatefulWidget {
  const ViewWalletInfo({super.key, required this.wallet, required this.user});

  final WalletEntity wallet;
  final SimpleUser user;

  @override
  _ViewWalletInfo createState() => _ViewWalletInfo();
}

class _ViewWalletInfo extends State<ViewWalletInfo> {
  final ViewWalletDetail detailChild = const ViewWalletDetail();
  late WalletDTO walletDto;
  late WalletServiceImpl walletService =
  Provider.of<WalletServiceImpl>(context, listen: false);
  bool _showSaldo = false;
  final bool _isLoading = true;
  late String balance = "0";
  late String balanceInUsd = "0";
  late String title = "";
  late String address = "";

  _ViewWalletInfo();

  TextSpan addressText() {
    return TextSpan(
        text: address,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadWalletData();
  }

  loadWalletData() async {
    return await Future.delayed(const Duration(seconds: 3), () {
      walletService.createWalletToDisplay(widget.wallet).then((dto) => {
        setState(() {
          walletDto = dto;
          title = walletDto.getName();
          balance = walletDto.valueInWeiFormatted;
          balanceInUsd = walletDto.valueInUsdFormatted;
          address = walletDto.getAddress();
          //_isLoading = false;
        })
      });
    });
  }

  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete $title'),
          content: const Text(
            'Do you really want to delete this wallet?\n'
                'If you have not backed up the seed, \n'
                'this wallet can no longer be recovered. \n'
                'We are not responsible for possible losses of funds.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Delete'),
              onPressed: () async {
                walletService.delete(widget.wallet);
                showMessage("Wallet deleted", context);
                final List<WalletEntity> wallets =
                await walletService.getWallets(widget.user.email);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => HomePage(
                      wallets: wallets,
                      user: widget.user,
                    )));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildFirstLine() {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: Padding(
        padding:
        const EdgeInsets.only(left: 10, top: 1, bottom: 10, right: 10),

        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                const Icon(Icons.wallet_rounded, size: 40, color: Colors.white),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: Color.fromRGBO(255, 113, 224, 1),
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showSaldo = !_showSaldo;
                });
              },
              child: SvgPicture.asset(
                _showSaldo
                    ? "assets/icons/eye-off-svgrepo-com.svg"
                    : "assets/icons/eye-svgrepo-com.svg",
                semanticsLabel: "view",
                width: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondLine() {
    return ShimmerLoading(
      isLoading: _isLoading,
      child:  Padding(
        padding: const EdgeInsets.only(
            left: 10, top: 10, bottom: 10, right: 10),
        child: Row(
          children: [
            const Icon(
              Icons.wallet_rounded,
              color: Color.fromRGBO(7, 255, 208, 1),
              size: 48,
            ),
            _showSaldo
                ? Text.rich(
              addressText(),
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
                backgroundColor: Color.fromRGBO(
                    7, 255, 208, 1),
                fontSize: 20,
              ),
            )
                : Container(
                height: 32,
                width: 230,
                color: Colors.grey[200]),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              child: const Icon(Icons.copy,
                  color: Colors.white),
              onTap: () async {
                await Clipboard.setData(ClipboardData(
                    text: widget.wallet.publicKey
                        .toString()));
                showMessage(
                    "Copied to the clipboard", context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Shimmer(
        linearGradient: shimmerGradient,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
              border: Border.all(color: Colors.white)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildFirstLine(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10, right: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _buildSecondLine(),
                              GestureDetector(
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 10,
                                            bottom: 10,
                                            right: 10),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/rbtc2.png",
                                              width: 48,
                                            ),
                                            _showSaldo
                                                ? Text.rich(
                                              TextSpan(
                                                  text: balance,
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    backgroundColor:
                                                    green(),
                                                  )),
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 28,
                                              ),
                                            )
                                                : Container(
                                                height: 32,
                                                width: 230,
                                                color: Colors.grey[200]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 10,
                                            bottom: 10,
                                            right: 10),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.monetization_on_rounded,
                                              color: Color.fromRGBO(
                                                  121, 198, 0, 1),
                                              size: 48,
                                            ),
                                            _showSaldo
                                                ? Text.rich(
                                              TextSpan(
                                                  text: balanceInUsd,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      backgroundColor:
                                                      Color.fromRGBO(
                                                          121,
                                                          198,
                                                          0,
                                                          1))),
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 28,
                                              ),
                                            )
                                                : Container(
                                                height: 32,
                                                width: 230,
                                                color: Colors.grey[200]),
                                          ],
                                        ),
                                      ),
                                    ]),
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                        DetailList(child: detailChild),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
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
                                  ));
                                  //if
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
