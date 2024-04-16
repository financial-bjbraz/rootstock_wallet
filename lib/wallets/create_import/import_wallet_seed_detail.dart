import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../entities/simple_user.dart';
import '../../entities/wallet_entity.dart';
import '../../pages/home_page.dart';
import '../../services/wallet_service.dart';
import '../../util/util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImportNewWalletBySeedDetail extends StatefulWidget {
  const ImportNewWalletBySeedDetail({Key? key}) : super(key: key);

  @override
  _ImportNewWalletBySeedDetail createState() => _ImportNewWalletBySeedDetail();
}

class _ImportNewWalletBySeedDetail extends State<ImportNewWalletBySeedDetail> {
  late WalletServiceImpl walletService = Provider.of<WalletServiceImpl>(context, listen: false);
  bool inputSeedEnabled = true;

  Widget build(BuildContext context) {
    final TextEditingController mailController = TextEditingController();

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
                  "Importar uma nova wallet",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: const Color.fromRGBO(7, 255, 208, 1),
        ),
        body: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
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
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text.rich(
                                      TextSpan(
                                          text: "Insert your seed",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 28,
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    TextField(
                                      controller: mailController,
                                      enabled: inputSeedEnabled,
                                      decoration: InputDecoration(
                                          labelText:
                                              "Type or Paste your Seed",
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 5,
                                                  color: Colors.white)),
                                          suffixIcon: IconButton(
                                            icon: const Icon(Icons.done),
                                            splashColor: Colors.white,
                                            onPressed: () {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                            },
                                          )),
                                    ),
                                    const SizedBox(height: 20,),
                                    ElevatedButton(
                                      onPressed: () async {
                                        var seed = mailController.text;

                                        if(seed.isEmpty) {
                                          showMessage("Invalid Seed", context);
                                        } else {
                                          var privateKey = await walletService.getPrivateKey(seed);
                                          var publicKey = await walletService.getPublicKeyString(privateKey);
                                          WalletEntity wallet = WalletEntity(privateKey: privateKey, publicKey: publicKey, walletId: "", walletName: "");

                                          walletService.persistNewWallet(wallet);
                                          showMessage("Account #2 Created", context);
                                          Navigator.of(context)
                                              .pushReplacement(MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                user: SimpleUser(
                                                    name: AppLocalizations.of(context)!.anonimus,
                                                    email:
                                                    "${AppLocalizations.of(context)!.passwordField}@${AppLocalizations.of(context)!.passwordField}.com"),
                                              )));

                                        }
                                      },
                                      style: raisedButtonStyle,
                                      child: const Row(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.key),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Validate and Import",
                                                style:
                                                TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
              ),
            ],
          ),
        ));
  }
}
