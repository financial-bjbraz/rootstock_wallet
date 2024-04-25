import 'package:flutter/material.dart';
import 'package:my_rootstock_wallet/pages/transactions.dart';
import 'package:my_rootstock_wallet/entities/simple_user.dart';
import 'package:my_rootstock_wallet/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_rootstock_wallet/services/auth.dart';

import '../util/util.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    verifyAndCreateDataBase();
    return Container(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String MESSAGE_INVALID_EMAIL = "Invalid email";
  String MESSAGE_INVALID_PASSWORD =
      "Invalid Password. Password must not be least than 8 chars";

  TextEditingController passwordController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  late bool _buttonPressed = false;
  late String _email, _password;

  late User user;
  final auth = FirebaseAuth.instance;

  Widget loginButton() {
    final String loginAnonimousText = AppLocalizations.of(context)!.alogin;
    final String login = AppLocalizations.of(context)!.login;
    final String createAccount = AppLocalizations.of(context)!.createAccount;
    final String title = AppLocalizations.of(context)!.title;

    FocusNode textSecondFocusNode = FocusNode();

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(33.0),
              child: Image.asset('assets/images/maniva.png',
                  height: 30),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: this.mailController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person, color: Colors.white,),
                            labelText: AppLocalizations.of(context)!.emailField,
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 5, color: Colors.white)),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.done, color: Colors.white,),
                              splashColor: Colors.white,
                              tooltip: "Submit",
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(textSecondFocusNode);
                              },
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        focusNode: textSecondFocusNode,
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person, color: Colors.white,),
                            labelText:
                                AppLocalizations.of(context)!.passwordField,
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.done),
                              splashColor: Colors.white,
                              tooltip: "Submit",
                              color: Colors.white,
                              onPressed: () {},
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (validate()) {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => TransactionsPage(
                                            user: SimpleUser(
                                                name: mailController.text,
                                                email: mailController.text),
                                          )));
                            }
                          },
                          style: greenButtonStyle,
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  const Icon(Icons.create, color: Colors.white,),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    login,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.chevron_right,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (validate()) {}
                          },
                          style: orangeButton,
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  const Icon(Icons.login_rounded, color: Colors.white,),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    createAccount,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.chevron_right,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ]),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text.rich(
                    TextSpan(
                      text: "Or ",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  OutlinedButton(
                    onPressed: clickLoginAnonimous,
                    style: pinkButtonStyle,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/anonimous.png",
                              color: Colors.white,
                              height: 30,
                              width: 70,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                loginAnonimousText,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void clickLoginAnonimous() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          user: SimpleUser(
              name: AppLocalizations.of(context)!.anonimus,
              email:
                  "${AppLocalizations.of(context)!.passwordField}@${AppLocalizations.of(context)!.passwordField}.com"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: loginButton(),
    );
  }

  bool validate() {
    var email = mailController.text;
    var password = passwordController.text;
    var message = "";

    // if (email.isEmpty) {
    //   showMessage(MESSAGE_INVALID_EMAIL);
    //   return false;
    // }
    //
    // if (password.isEmpty) {
    //   showMessage(MESSAGE_INVALID_PASSWORD);
    //   return false;
    // }
    //
    // if (password.length < 8) {
    //   showMessage(MESSAGE_INVALID_PASSWORD);
    //   return false;
    // }

    return true;
  }

  void showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
