import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletInfo extends StatelessWidget {
  const WalletInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.wallet, color: Colors.grey),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context)!.wallet,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
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
                        Text(
                          AppLocalizations.of(context)!.saldo,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.teal,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text.rich(
                          TextSpan(text: "R\$ ", children: [
                            TextSpan(
                                text: "600 ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(text: ",50")
                          ]),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 28,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                              text: AppLocalizations.of(context)!
                                  .saldoUltimoMes,
                              children: const [
                                TextSpan(
                                    text: " R\$ 2.200.95",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ]),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
                        flex: 2, child: Container(color: Colors.blue)),
                    Expanded(
                        flex: 3, child: Container(color: Colors.green)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
