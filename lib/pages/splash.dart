import 'package:my_rootstock_wallet/pages/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    delay();
  }

  Future<void> delay() async {
    return await Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return const LoginPage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.asset(
            "assets/images/maniva.png",
            height: 180,
          ),
        ));
  }
}
