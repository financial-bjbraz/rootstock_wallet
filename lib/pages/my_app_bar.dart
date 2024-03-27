import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final bool showMenu;
  final VoidCallback onTap;
  final String userName;

  const MyAppBar(
      {Key? key,
      required this.showMenu,
      required this.onTap,
      required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            color: Color(0x293145),
            height: MediaQuery.of(context).size.height * .20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/bjbraz-logo.png',
                        height: 30, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      this.userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Icon(showMenu ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
