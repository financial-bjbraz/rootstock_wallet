import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

class ViewWalletApp extends StatefulWidget {
  const ViewWalletApp({super.key, required this.wallet});

  final WalletEntity wallet;

  @override
  _ViewWalletApp createState() => _ViewWalletApp();
}

class _ViewWalletApp extends State<ViewWalletApp>
    with AutomaticKeepAliveClientMixin {
  final ViewWalletDetail detailChild = const ViewWalletDetail();
  late WalletDTO walletDto;
  late WalletServiceImpl walletService =
      Provider.of<WalletServiceImpl>(context, listen: false);
  bool _showSaldo = false;
  late String balance = "0";
  late String balanceInUsd = "0";
  late String title = "";
  late String address = "";

  _ViewWalletApp();

  @override
  bool get wantKeepAlive => true;

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
    return await Future.delayed(const Duration(seconds: 5), () {
      walletService.createWalletToDisplay(widget.wallet).then((dto) => {
        setState(() {
          walletDto = dto;
          title = walletDto.getName();
          balance = walletDto.valueInWeiFormatted;
          balanceInUsd = walletDto.valueInUsdFormatted;
          address = walletDto.getAddress();
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
              onPressed: () {
                walletService.delete(widget.wallet);
                showMessage("Wallet deleted", context);

                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(
                    builder: (context) => HomePage(
                      user: SimpleUser(
                          name: AppLocalizations.of(
                              context)!
                              .anonimus,
                          email:
                          "${AppLocalizations.of(context)!.passwordField}@${AppLocalizations.of(context)!.passwordField}.com",
                      password: ""),
                    )));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    loadWalletData();
    return Padding(
      padding: const EdgeInsets.all(20),
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: <Widget>[
                              const Icon(Icons.wallet_rounded,
                                  color: Colors.grey),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                title,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.white,
                                    backgroundColor:
                                        Color.fromRGBO(255, 113, 224, 1),
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
                                  ? "assets/icons/eye-off-outline.svg"
                                  : "assets/icons/eye-outline.svg",
                              semanticsLabel: "visualizar",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showSaldo = !_showSaldo;
                                dialogBuilder(context);

                              });
                            },
                            child: SvgPicture.asset(
                              "assets/icons/delete-button.svg",
                              width: 20,
                              semanticsLabel: "excluir",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
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
                                            backgroundColor:
                                                Color.fromRGBO(7, 255, 208, 1),
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
                                        color: Colors.grey),
                                    onTap: () async {
                                      await Clipboard.setData(ClipboardData(
                                          text: widget.wallet.publicKey.toString()));
                                      showMessage(
                                          "Copied to the clipboard", context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          const Icon(
                                            Icons.money,
                                            color: Color.fromRGBO(
                                                158, 118, 255, 1),
                                            size: 48,
                                          ),
                                          _showSaldo
                                              ? Text.rich(
                                                  TextSpan(
                                                      text: balance,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        backgroundColor:
                                                            Color.fromRGBO(158,
                                                                118, 255, 1),
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
                                            color:
                                                Color.fromRGBO(121, 198, 0, 1),
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
    );
  }
}
