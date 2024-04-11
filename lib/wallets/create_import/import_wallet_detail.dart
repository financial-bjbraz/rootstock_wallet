import 'package:flutter/material.dart';

class ImportNewWalletDetail extends StatelessWidget {
  const ImportNewWalletDetail({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(20),
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
                                    Text.rich(
                                      TextSpan(
                                            text: "Insert your private key",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 28,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                          text: "Limite disponível ",
                                          children: [
                                            TextSpan(
                                                text: " R\$ 2.200.95",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ]),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05),
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
                            width: 7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [

                        SizedBox(
                          height: 10,
                        ),

                      ],
                    ),
                  ),
                  color: Colors.grey[200],
                ),
              ),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     child: Text("Go Back"),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
