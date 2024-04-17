import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../entities/simple_user.dart';
import '../../entities/wallet_entity.dart';
import 'package:flutter/material.dart';
import '../../pages/home_page.dart';
import '../../services/wallet_service.dart';
import '../../util/util.dart';

class ViewWallet extends StatefulWidget {
  const ViewWallet({super.key, required this.wallet});
  final WalletEntity wallet;
  @override
  _ViewWallet createState() => _ViewWallet(wallet);
}

class _ViewWallet extends State<ViewWallet> with AutomaticKeepAliveClientMixin {
  late WalletServiceImpl walletService = Provider.of<WalletServiceImpl>(context, listen: false);
  bool _showSaldo = false;
  final WalletEntity wallet;
  _ViewWallet(this.wallet);

  @override
  bool get wantKeepAlive => true;

  TextSpan addressText() {
    return TextSpan(
        text: getAddress(wallet),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var id = wallet.walletId;
    String title = ""; //"""Wallet #$id";
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Column(
            children:  [
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
                              const Icon(Icons.wallet_rounded, color: Colors.grey),
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
                                  ? "assets/icons/eye-outline.svg"
                                  : "assets/icons/eye-off-outline.svg",
                              color: Colors.grey,
                              semanticsLabel: "visualizar",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showSaldo = !_showSaldo;
                                walletService.delete(wallet);
                                showMessage("Wallet deleted", context);

                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                    builder: (context) => HomePage(
                                      user: SimpleUser(
                                          name: AppLocalizations.of(context)!.anonimus,
                                          email:
                                          "${AppLocalizations.of(context)!.passwordField}@${AppLocalizations.of(context)!.passwordField}.com"),
                                    )));

                              });
                            },
                            child: SvgPicture.asset(
                               "assets/icons/delete-button.svg",
                              color: Colors.grey,
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
                                      ?
                                  Text.rich(
                                    addressText(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Color.fromRGBO(7, 255, 208, 1),
                                      fontSize: 20,
                                    ),
                                  ) : Container(
                                      height: 32,
                                      width: 180,
                                      color: Colors.grey[200]),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.money,
                                    color: Color.fromRGBO(158, 118, 255, 1),
                                    size: 48,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                        text: "0.00012345",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Color.fromRGBO(158, 118, 255, 1),
                                        )),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on_rounded,
                                    color: Color.fromRGBO(121, 198, 0, 1),
                                    size: 48,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                        text: " USD 125.43",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Color.fromRGBO(121, 198, 0, 1)
                                        )),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 10),
                  ],
                ),
              ),
            ],
          ),
    );
  }

}

