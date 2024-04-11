import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../wallets/create_import/import_wallet_detail.dart';

class ImportSeedPkApp extends StatelessWidget {
  final ImportNewWalletDetail detailChild = const ImportNewWalletDetail();

  const ImportSeedPkApp({super.key});

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 30, bottom: 5),
                      child: GestureDetector(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.add_circle,
                                color: Color.fromRGBO(7, 255, 208, 1),
                                size: 48,
                              ),
                              Text(
                                "Importar Seed ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    backgroundColor:
                                        Color.fromRGBO(7, 255, 208, 1),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          onTap: () {

                            final snackBar = SnackBar(
                              content: Text("Importar Seed"),
                              action: SnackBarAction(
                                label: 'Ok',
                                onPressed: () {},
                              ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      child: GestureDetector(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.add_circle,
                                color: Color.fromRGBO(7, 255, 208, 1),
                                size: 48,
                              ),
                              Text(
                                "Importar \nPrivate Key ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    backgroundColor:
                                        Color.fromRGBO(7, 255, 208, 1),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          onTap: () {

                            final snackBar = SnackBar(
                              content: Text("Importar Private Key"),
                              action: SnackBarAction(
                                label: 'Ok',
                                onPressed: () {},
                              ),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          }),
                    ),
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
