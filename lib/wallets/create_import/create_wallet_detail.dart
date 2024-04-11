import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/src/credentials/address.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../services/wallet_service.dart';
import 'package:flutter/services.dart';

class CreateNewWalletDetail extends StatefulWidget {
  const CreateNewWalletDetail({Key? key}) : super(key: key);

  @override
  _CreateNewWalletDetail createState() => _CreateNewWalletDetail();
}

class _CreateNewWalletDetail extends State<CreateNewWalletDetail> {
  late bool _showSeed;
  bool _created = false;
  late WalletServiceImpl walletService;
  List<String> splittedMnemonic = List<String>.filled(1, "");
  late EthereumAddress address;

  @override
  void initState() {
    super.initState();
    _showSeed = false;
  }

  void createNewAccount() async {
    if(!_created) {
      walletService = Provider.of<WalletServiceImpl>(context);
      //showMessage("Gerando uma nova conta");
      final mnemonic = walletService.generateMnemonic();
      final privateKey = await walletService.getPrivateKey(mnemonic);
      address = await walletService.getPublicKey(privateKey);
      splittedMnemonic = mnemonic.split(' ');
      print(splittedMnemonic);
      print(splittedMnemonic.length);
      print(splittedMnemonic.elementAt(1));
      print(mnemonic);
      print(privateKey);
      print(address);
      //showMessage("Nova conta gerada com sucesso!");
      setState(() {
        splittedMnemonic = mnemonic.split(' ');
        print(splittedMnemonic);
        print(splittedMnemonic.length);
        print(splittedMnemonic.elementAt(2));
        _showSeed = true;
      });
      _created = !_created;
    }
  }

  Widget build(BuildContext context) {
    int contador = 0;
    createNewAccount();
    final String copy = AppLocalizations.of(context)!.copiar;

    Widget createTextFieldWithSeed(String word) {
      contador++;
      return Expanded(
        child: TextFormField(
          enabled: false,
          style: const TextStyle(
              fontSize: 6
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(2, 2, 2, 1),
            labelText: "$contador. $word",
          ),
        ),
      );
    }

    EdgeInsets createPaddingBetweenRows() {
      return const EdgeInsets.only(left: 2, top: 5, bottom: 5, right: 2);
    }

    EdgeInsets createPaddingBetweenDifferentRows() {
      return const EdgeInsets.only(left: 2, top: 45, bottom: 5, right: 2);
    }

    void showMessage(String message) {
      final snackBar = SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Icon(Icons.add_circle, color: Colors.white),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Criando uma nova wallet",
                  style: TextStyle(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: createPaddingBetweenRows(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                      const SizedBox(width: 5),
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                      const SizedBox(width: 5),
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: createPaddingBetweenRows(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                      const SizedBox(width: 5),
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                      const SizedBox(width: 5),
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: createPaddingBetweenRows(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                      const SizedBox(width: 5),
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                      const SizedBox(width: 5),
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: createPaddingBetweenRows(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                      const SizedBox(width: 5),
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                      const SizedBox(width: 5),
                                      createTextFieldWithSeed(splittedMnemonic.elementAt(contador)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: createPaddingBetweenDifferentRows(),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await Clipboard.setData(ClipboardData(text: splittedMnemonic.toString().replaceAll("[", "").replaceAll("]", "")));
                                      showMessage("Copied to the clipboard");
                                    },
                                    style: raisedButtonStyle,
                                    child: Row(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            const Icon(Icons.copy),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              copy,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // SizedBox(

                            //   width: double.infinity,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: <Widget>[
                            //       GestureDetector(
                            //           onTap: () async {
                            //             _dialogBuilder(context);
                            //           },
                            //           child:const Text.rich(
                            //             TextSpan(
                            //                 text: "Clique aqui para \n gerar o seed",
                            //                 style: TextStyle(
                            //                   fontWeight: FontWeight.bold,
                            //                 )),
                            //             textAlign: TextAlign.start,
                            //             style: TextStyle(
                            //               color: Colors.teal,
                            //               fontSize: 28,
                            //             ),
                            //           ),
                            //       ),
                            //
                            //
                            //
                            //     ],
                            //   ),
                            //
                            // ),
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
