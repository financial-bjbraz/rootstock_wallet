import 'package:big_dart/big_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_rootstock_wallet/entities/wallet_dto.dart';
import '../../entities/simple_user.dart';
import '../../services/wallet_service.dart';
import '../../util/decimal_input.dart';
import '../../util/util.dart';

class Send extends StatefulWidget {
  const Send({super.key, required this.user, required this.walletDto});
  final SimpleUser user;
  final WalletDTO walletDto;

  @override
  _Send createState() {
    return _Send();
  }
}

class _Send extends State<Send> {
  _Send();
  bool processing = false;
  bool full = true;
  double _currentSliderValue = 5;
  String address = '';
  late WalletServiceImpl walletService;
  List<String> splittedMnemonic = List<String>.filled(1, '');
  final valueController = TextEditingController();
  String balance = '0';
  String balanceInUsd = '0';
  final TextEditingController addressController = TextEditingController();
  bool sendingTransaction = false;
  bool success = false;
  final amountController = TextEditingController();
  final destinationAddressController = TextEditingController();

  Icon fullIcon = const Icon(
    Icons.account_balance_wallet,
    color: Colors.black,
  );

  @override
  void initState() {
    super.initState();
    walletService = WalletServiceImpl();
  }

  @override
  void dispose() {
    if (address.isEmpty) {
      address = widget.walletDto.getAddress();
    }
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (address.isEmpty) {
      address = widget.walletDto.getAddress();
    }

    destinationAddressController.text = '0xF00A0Dc6B9A830fe13942369aA4FAF57F935b3d2';

    balance = widget.walletDto.valueInWeiFormatted;
    balanceInUsd = widget.walletDto.valueInUsdFormatted;

    final String sendTransaction =
        AppLocalizations.of(context)!.sendTransaction;

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
                sendTransaction,
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
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.wallet_rounded,
                  color: lightBlue(),
                  size: 48,
                ),
                Expanded(
                    child: TextField(
                  style: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Color.fromRGBO(7, 255, 208, 1),
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(labelText: "Destination Address"),
                  keyboardType: TextInputType.text,
                      controller: destinationAddressController,
                )),
                ElevatedButton(
                  style: blackWhiteButton,
                  onPressed: () {},
                  child: const Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.document_scanner_outlined,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Scan",
                                style: smallBlackText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Paste or Scan",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: Row(
            children: [
              Image.asset(
                "assets/icons/rbtc2.png",
                width: 48,
              ),
              Expanded(
                child: TextField(
                  style: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Color.fromRGBO(7, 255, 208, 1),
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(labelText: "Enter amount"),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [DecimalTextInputFormatter(decimalRange: 18)],
                  controller: amountController,// Only numbers can be entered
                ),
              ),
              ElevatedButton(
                style: blackWhiteButton,
                onPressed: () {
                  setState(() {
                    if (full) {
                      fullIcon = const Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.black,
                      );
                    } else {
                      fullIcon = const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.black,
                      );
                    }
                    full = !full;
                  });
                },
                child: Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        fullIcon,
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Max",
                          style: smallBlackText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Max available: ${balance}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: Slider(
                  value: _currentSliderValue,
                  max: 10,
                  divisions: 2,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              )
            ],
          )),
          const Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Select fee level",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              flex: 3,
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: !sendingTransaction
                          ? ElevatedButton(
                              style: blackWhiteButton,
                              onPressed: () async {
                                setState(() {
                                  sendingTransaction = true;
                                });
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                setState(() {
                                  try {
                                    var pointedText = amountController.text;
                                    pointedText = pointedText.replaceAll(",", ".");
                                    var bp = Big(pointedText);
                                    print(bp.toStringAsFixed(dp: 18, rm: RoundingMode.roundHalfEven));
                                    print(bp.times(1000000000000000000));


                                    walletService.sendRBTC(
                                        widget.walletDto.wallet,
                                        destinationAddressController.text,
                                        BigInt.parse(bp.times(1000000000000000000).toString()));
                                    success = true;
                                  }catch(e){
                                    success = false;
                                    final snackBar = SnackBar(
                                      content: const Text("Error sending transaction, change values and try again"),
                                      action: SnackBarAction(
                                        label: 'Ok',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    sendingTransaction = false;
                                  }
                                });
                                await Future.delayed(
                                    const Duration(milliseconds: 500));

                                if(success) {
                                  Navigator.pop(context);
                                }
                              },
                              child: const Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.send),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Send Transaction",
                                        style: blackText,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : !success
                              ? const LinearProgressIndicator()
                              : const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
