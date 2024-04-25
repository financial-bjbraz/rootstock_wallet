import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottonMenuNew extends StatelessWidget{
  const BottonMenuNew({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        items: const [
          Icon(Icons.home),
          Icon(Icons.favorite),
          Icon(Icons.settings)
      ]),
    );
  }

}