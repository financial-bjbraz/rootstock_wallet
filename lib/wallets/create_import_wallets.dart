import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CreateImportWallets extends StatelessWidget {

  const CreateImportWallets({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/sad_image.png",
                  height: 30,
                  width: 90,
                ),
                Text(
                  "Nenhuma wallet criada ainda",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
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
                              text: "Criar nova wallet",
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
                              text: "Importar wallet",
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
    );
  }



}