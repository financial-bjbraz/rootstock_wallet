import 'package:flutter/material.dart';
import 'package:my_rootstock_wallet/entities/wallet.dart';
import 'package:my_rootstock_wallet/services/wallet_service.dart';
import 'package:provider/provider.dart';

class CreateWallet extends StatelessWidget {
  const CreateWallet({super.key});

  @override
  Widget build(BuildContext context) {
    final walletService = Provider.of<WalletServiceImpl>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Column(
        children: [
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
                        color: Color.fromRGBO(158, 118, 255, 1),
                        size: 48,
                      ),
                      Text(
                        "Criar uma \n nova wallet ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            backgroundColor: Color.fromRGBO(158, 118, 255, 1),
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
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
                              // Icon(
                              //   Icons.add_circle,
                              //   color: Colors.grey[400],
                              //   size: 48,
                              // ),
                              // Text.rich(
                              //   const TextSpan(
                              //       text: "Criar uma nova wallet",
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //       )),
                              //   textAlign: TextAlign.start,
                              //   style: TextStyle(
                              //     color: Colors.grey[400],
                              //     fontSize: 28,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
