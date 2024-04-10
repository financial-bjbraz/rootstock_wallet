import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/src/credentials/address.dart';

import '../../services/wallet_service.dart';

class CreateNewWalletDetail extends StatefulWidget {
  const CreateNewWalletDetail({Key? key}) : super(key: key);

  @override
  _CreateNewWalletDetail createState() => _CreateNewWalletDetail();
}

class _CreateNewWalletDetail extends State<CreateNewWalletDetail> {
  late bool _showSeed;

  @override
  void initState() {
    super.initState();
    _showSeed = false;
  }

  Widget build(BuildContext context) {

    final walletService = Provider.of<WalletServiceImpl>(context);
    List<String> splittedMnemonic = List<String>.filled(1, "");
    EthereumAddress address;

    void showMessage(String message) {
      final snackBar = SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void createNewAccount() async {
      showMessage("Gerando uma nova conta");
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
      showMessage("Nova conta gerada com sucesso!");
      setState(() {
        splittedMnemonic = mnemonic.split(' ');
        print(splittedMnemonic);
        print(splittedMnemonic.length);
        print(splittedMnemonic.elementAt(2));
        _showSeed = true;
      });
    }

    Future<void> _dialogBuilder(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Create new seed'),
            content: const Text(
              'You will create a new seed and from this seed a new private key and an account will be generated.\n'
                  'Make sure you have privacy so that your seed and privateKey are not copied.\n'
                  'Make sure you make a backup or you may lose access to your account.\n'
                  'We are not responsible for lost seeds.\n'
                  'Are you sure you want to create a new seed \n'
                  'and that you are in a safe environment to do so?',
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
                child: const Text('Create'),
                onPressed: () {
                  Navigator.of(context).pop();
                  createNewAccount();
                },
              ),
            ],
          );
        },
      );
    }

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
          backgroundColor: const Color.fromRGBO(255, 112, 224, 1),
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
                                    GestureDetector(
                                        onTap: () async {
                                          _dialogBuilder(context);
                                        },
                                        child:const Text.rich(
                                          TextSpan(
                                              text: "Clique aqui para \n gerar o seed",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.teal,
                                            fontSize: 28,
                                          ),
                                        ),
                                    ),



                                  ],
                                ),

                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Expanded(child: TextField()),
                                Expanded(child: TextField()),
                              ],
                            ),

                          ],
                        ),
                      ),
                      Expanded(child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "aaaaaa",
                            prefixIcon: const Icon(Icons.person),
                            border: const OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 5, color: Colors.white)),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.done),
                              splashColor: Colors.white,
                              tooltip: "Submit",
                              onPressed: () {

                              },
                            )),
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
