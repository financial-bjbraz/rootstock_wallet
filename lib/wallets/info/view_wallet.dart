import 'package:flutter/material.dart';
import 'package:my_rootstock_wallet/entities/wallet.dart';

class ViewWallet extends StatelessWidget {
  const ViewWallet({super.key, required this.wallet});

  final Wallet wallet;

  TextSpan addressText() {
    return TextSpan(
        text: wallet.getAddress(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ));
  }

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
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          // Image.asset(
                          //   "assets/images/happy.png",
                          //   height: 30,
                          //   width: 90,
                          //   color: Color.fromRGBO(222, 255, 27, 1),
                          // ),
                          Text(
                            "Wallet #1",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Color.fromRGBO(255, 113, 224, 1),
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10, right: 10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.wallet_rounded,
                                    color: Color.fromRGBO(7, 255, 208, 1),
                                    size: 48,
                                  ),
                                  Text.rich(
                                    addressText(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Color.fromRGBO(7, 255, 208, 1),
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.money,
                                    color: Color.fromRGBO(158, 118, 255, 1),
                                    size: 48,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                        text: "0.00012345",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Color.fromRGBO(158, 118, 255, 1),
                                        )),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on_rounded,
                                    color: Color.fromRGBO(121, 198, 0, 1),
                                    size: 48,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                        text: " USD 125.43",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Color.fromRGBO(121, 198, 0, 1)
                                        )),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.white,
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
                    const SizedBox(
                        height: 10),
                  ],
                ),
              ),
            ],
          ),
    );
  }

}
