import 'package:flutter/material.dart';
import 'package:my_rootstock_wallet/entities/wallet.dart';

class ImportWallet extends StatelessWidget {
  const ImportWallet({super.key, required this.wallet});

  final Wallet wallet;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Column(
        children:  [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(

                    children: [
                      Icon(
                        Icons.add_circle,
                        color:  Color.fromRGBO(7, 255, 208, 1),
                        size: 48,
                      ),
                      Text(
                        "Importar seed  \n ou Private Key ",

                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            backgroundColor: Color.fromRGBO(7, 255, 208, 1),
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 20, bottom: 20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle,
                                color: Colors.grey[400],
                                size: 48,
                              ),
                              Text.rich(
                                const TextSpan(
                                    text: "Importar seed",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.grey[400],
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
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }



}
