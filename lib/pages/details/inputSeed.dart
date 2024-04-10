
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountStatementsDetail extends StatelessWidget {
  bool _showSaldo = false;
  String currentBalance = "R\$ 0,00";

  Widget build(BuildContext context) {
    return Expanded(child: TextFormField(
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
    );
  }
}
