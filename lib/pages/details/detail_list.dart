import 'package:flutter/material.dart';

class DetailList extends StatelessWidget {
  final Widget child;

  const DetailList({Key? key, required this.child}) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: child,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
        ));
  }
}
