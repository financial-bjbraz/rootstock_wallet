import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_rootstock_wallet/entities/wallet_dto.dart';
import 'package:my_rootstock_wallet/pages/details/detail_list.dart';
import 'package:my_rootstock_wallet/wallets/info/account_receive.dart';
import 'package:my_rootstock_wallet/wallets/info/account_send.dart';
import 'package:provider/provider.dart';
import '../../entities/simple_user.dart';
import '../../services/wallet_service.dart';
import '../entities/wallet_entity.dart';
import '../util/util.dart';
import 'widget_shimmer.dart';
import 'shimmer_loading.dart';

class ViewWalletApp extends StatefulWidget {
  const ViewWalletApp({super.key, required this.wallet, required this.user});

  final WalletEntity wallet;
  final SimpleUser user;

  @override
  _ViewWalletApp createState() => _ViewWalletApp();
}

class _ViewWalletApp extends State<ViewWalletApp> {
  late WalletDTO walletDto;
  late WalletServiceImpl walletService =
      Provider.of<WalletServiceImpl>(context, listen: false);
  bool _showSaldo = true;
  bool _isLoading = true;
  final double icon_size = 48;
  late String balance = "0";
  late String balanceInUsd = "0";
  late String address = formatAddress(widget.wallet.publicKey);
  int operation = 0;
  bool loaded = false;

  TextEditingController addressController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  _ViewWalletApp();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadWalletData();
  }

  loadWalletData() async {
    if (_isLoading) {
      await Future.delayed(const Duration(seconds: 3), () {
        walletService.createWalletToDisplay(widget.wallet).then((dto) => {
              setState(() {
                walletDto = dto;
                balance = walletDto.valueInWeiFormatted;
                balanceInUsd = walletDto.valueInUsdFormatted;
                _isLoading = false;
              })
            });
      });
    }
  }

  Widget _buildFirstLine() {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 1, bottom: 5, right: 10),
        child: Row(
          children: <Widget>[
            Icon(Icons.wallet_rounded, size: icon_size, color: pink()),
            const SizedBox(
              width: 5,
            ),
            Text(
              (widget.wallet.walletName + widget.wallet.walletId),
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  backgroundColor: pink(),
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createMainScreen() {
    return Column(
      children: [
        ShimmerLoading(
          isLoading: _isLoading,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
            child: Row(
              children: [
                Icon(
                  Icons.wallet_rounded,
                  color: lightBlue(),
                  size: icon_size,
                ),
                _showSaldo
                    ? Text.rich(
                        addressText(address),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.white,
                          backgroundColor: Color.fromRGBO(7, 255, 208, 1),
                          fontSize: 20,
                        ),
                      )
                    : Container(
                        height: 32, width: 230, color: Colors.grey[200]),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  child: Icon(Icons.copy, color: lightBlue()),
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(
                        text: widget.wallet.publicKey.toString()));
                    showMessage("Copied to the clipboard", context);
                  },
                ),
              ],
            ),
          ),
        ),
        ShimmerLoading(
            isLoading: _isLoading,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, bottom: 10, right: 10),
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
                                fontWeight: FontWeight.bold,
                                backgroundColor: orange(),
                              )),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        )
                      : Container(
                          height: 32, width: 230, color: Colors.grey[200]),
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
                        color: orange()),
                  ),
                ],
              ),
            )),
        ShimmerLoading(
          isLoading: _isLoading,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.monetization_on_rounded,
                  color: Color.fromRGBO(121, 198, 0, 1),
                  size: 48,
                ),
                _showSaldo
                    ? Text.rich(
                        TextSpan(
                            text: balanceInUsd,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                backgroundColor:
                                    Color.fromRGBO(121, 198, 0, 1))),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      )
                    : Container(
                        height: 32, width: 230, color: Colors.grey[200]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonsLine() {
    final String send = AppLocalizations.of(context)!.send;
    final String receive = AppLocalizations.of(context)!.receive;

    return ShimmerLoading(
      isLoading: _isLoading,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: blackWhiteButton,
              onPressed: (){
                final Send sendScreenChild =
                Send(user: widget.user, walletDto: walletDto);
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      DetailList(child: sendScreenChild),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(0.0, 1.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;
                    var tween =
                    Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ));
              },
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.call_made,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        send,
                        style: blackText,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ElevatedButton(
              style: blackWhiteButton,
              onPressed: () {
                final Receive receiveScreenChild =
                    Receive(user: widget.user, walletDto: walletDto);
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      DetailList(child: receiveScreenChild),
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
                ));
              },
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.call_received,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(receive, style: blackText),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      loadWalletData();
    } else {
      _isLoading = false;
    }
  }

  @override
  void dispose() {
    _isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Shimmer(
        linearGradient: shimmerGradient,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(color: Colors.white)),
          child: ListView(
            physics: _isLoading ? const NeverScrollableScrollPhysics() : null,
            children: [
              _buildFirstLine(),
              const SizedBox(height: 16),
              _createMainScreen(),
              const SizedBox(height: 16),
              _buttonsLine(),
            ],
          ),
        ),
      ),
    );
  }
}
