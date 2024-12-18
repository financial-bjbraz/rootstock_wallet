import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_rootstock_wallet/entities/wallet_dto.dart';
import '../../entities/simple_user.dart';
import '../../services/wallet_service.dart';
import '../../util/util.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Receive extends StatefulWidget {
  final SimpleUser user;
  final WalletDTO walletDto;
  const Receive({super.key, required this.user, required this.walletDto});

  @override
  _Receive createState() {
    return _Receive();
  }
}

class _Receive extends State<Receive> {
  bool processing = false;
  final ethereum = "ethereum:";
  String address = "";
  String completeAddress = "";
  late WalletServiceImpl walletService;
  List<String> splittedMnemonic = List<String>.filled(1, "");
  final valueController = TextEditingController();
  late String balance = "0";
  late String balanceInUsd = "0";

  _Receive();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    processAddress();
    valueController.dispose();
    super.dispose();
  }

  processAddress() {
    if (address.isEmpty) {
      address = widget.walletDto.getAddress();
      completeAddress = widget.walletDto.getCompleteAddress();
    }
  }

  @override
  Widget build(BuildContext context) {
    processAddress();
    final String receiveTransactions =
        AppLocalizations.of(context)!.receiveTransactions;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                const Icon(Icons.add_circle, color: Colors.white),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  receiveTransactions,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: const Color.fromRGBO(158, 118, 255, 1),
        ),
        body: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          const Text("Your Rootstock address", style: TextStyle(color: Colors.black, fontSize: 24),),
                          QrImageView(
                            data: ethereum + completeAddress,
                            version: QrVersions.auto,
                            backgroundColor: Colors.white,
                            embeddedImage:
                                Image.asset("assets/icons/rbtc2.png").image,
                            size: 250.0,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text.rich(
                                    addressText(completeAddress),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 20,
                            thickness: 5,
                            indent: 5,
                            endIndent: 0,
                            color: Colors.black,
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    child: const Icon(Icons.copy,
                                        color: Colors.black, size: 48,),
                                    onTap: () async {
                                      await Clipboard.setData(
                                          ClipboardData(text: completeAddress));
                                      showMessage(
                                          "Copied to the clipboard $completeAddress",
                                          context);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    child: const Icon(Icons.share,
                                        color: Colors.black, size: 48,
                                    ),
                                    onTap: () async {
                                      await Clipboard.setData(
                                          ClipboardData(text: completeAddress));
                                      showMessage(
                                          "Copied to the clipboard $completeAddress",
                                          context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 10,
                        right: 15,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          width: 7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Container(color: Colors.orange)),
                              Expanded(
                                  flex: 2,
                                  child: Container(color: Colors.blue)),
                              Expanded(
                                  flex: 3,
                                  child: Container(color: Colors.green)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
