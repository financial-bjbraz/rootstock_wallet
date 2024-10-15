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
import 'Shimmer.dart';
import 'ShimmerLoading.dart';

class ViewWalletApp extends StatefulWidget {
  const ViewWalletApp({super.key, required this.wallet, required this.user});

  final WalletEntity wallet;
  final SimpleUser user;

  @override
  _ViewWalletApp createState() => _ViewWalletApp();
}

class _ViewWalletApp extends State<ViewWalletApp> {
  final ViewWalletDetail detailChild = const ViewWalletDetail();
  late WalletDTO walletDto;
  late WalletServiceImpl walletService =
      Provider.of<WalletServiceImpl>(context, listen: false);
  bool _showSaldo = true;
  bool _isLoading = true;
  late String balance = "0";
  late String balanceInUsd = "0";
  late String address = "";

  _ViewWalletApp();

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
              balance = walletDto.valueInWeiFormatted;
              balanceInUsd = walletDto.valueInUsdFormatted;
              _isLoading = false;
            })
          });
    });
  }

  Widget _buildFirstLine() {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: Padding(
        padding:
        const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        child: Row(
          children: <Widget>[
                Icon(Icons.wallet_rounded, size: 40, color: pink()),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  (widget.wallet.walletName + widget.wallet.walletId),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: Color.fromRGBO(255, 113, 224, 1),
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),

              ],
            ),

      ),
    );
  }

  Widget _buildSecondLine() {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        child: Row(
          children: [
            Icon(
              Icons.wallet_rounded,
              color: lightBlue(),
              size: 48,
            ),
            _showSaldo
                ? Text.rich(
                    addressText(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      backgroundColor: Color.fromRGBO(7, 255, 208, 1),
                      fontSize: 20,
                    ),
                  )
                : Container(height: 32, width: 230, color: Colors.grey[200]),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              child: Icon(Icons.copy, color: lightBlue()),
              onTap: () async {
                await Clipboard.setData(
                    ClipboardData(text: widget.wallet.publicKey.toString()));
                showMessage("Copied to the clipboard", context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThirdLine() {
    return ShimmerLoading(
        isLoading: _isLoading,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
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
                  : Container(height: 32, width: 230, color: Colors.grey[200]),
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
                    width: 40, color: orange()
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildFourthLine() {
    return ShimmerLoading(
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
                            backgroundColor: Color.fromRGBO(121, 198, 0, 1))),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  )
                : Container(height: 32, width: 230, color: Colors.grey[200]),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    loadWalletData();
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
            const SizedBox(height: 16),
            _buildSecondLine(),
            _buildThirdLine(),
            _buildFourthLine(),
          ],
        ),
        ),
      ),
    );
  }
}
