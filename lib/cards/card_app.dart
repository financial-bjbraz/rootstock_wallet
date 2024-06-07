import 'package:flutter/material.dart';
import 'package:my_rootstock_wallet/pages/details/detail_list.dart';

class CardApp extends StatelessWidget {
  final Widget child;
  final Widget detailChild;

  const CardApp({super.key, required this.child, required this.detailChild});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.black, border: Border.all(color: Colors.white)),
          child: child,
        ),
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailList(child: detailChild),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ));
        //if
        },
      ),
    );
  }
}
