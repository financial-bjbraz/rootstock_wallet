import 'package:flutter/material.dart';

class DetailList extends StatelessWidget {
  final Widget child;

  const DetailList({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: child,
        ));
  }
}
