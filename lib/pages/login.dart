import 'package:flutter/material.dart';
import 'package:my_rootstock_wallet/pages/transactions.dart';
import 'package:my_rootstock_wallet/entities/simple_user.dart';
import 'package:my_rootstock_wallet/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_rootstock_wallet/services/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    final String loginGoogleText = AppLocalizations.of(context)!.glogin;
    final String loginAnonimousText = AppLocalizations.of(context)!.alogin;
    final String login = AppLocalizations.of(context)!.login;
    final String createAccount = AppLocalizations.of(context)!.createAccount;
    final String title = AppLocalizations.of(context)!.title;

    FocusNode textSecondFocusNode = FocusNode();

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    final ButtonStyle orangeButton = ElevatedButton.styleFrom(
      minimumSize: const Size(88, 36),
      backgroundColor: Color.fromRGBO(255, 145, 0, 1),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    final ButtonStyle greenButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(88, 36),
      backgroundColor: Color.fromRGBO(121, 198, 0, 1),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    final ButtonStyle pingButton = ElevatedButton.styleFrom(
      minimumSize: const Size(88, 36),
      backgroundColor: Color.fromRGBO(121, 198, 0, 1),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(33.0),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
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
                            prefixIcon: const Icon(Icons.person),
                            labelText: AppLocalizations.of(context)!.emailField,
                            border: const OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 5, color: Colors.white)),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.done),
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
                            prefixIcon: const Icon(Icons.person),
                            labelText: AppLocalizations.of(context)!.passwordField,
                            border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 5, color: Colors.white),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.done),
                              splashColor: Colors.white,
                              tooltip: "Submit",
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
                          style: raisedButtonStyle,
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  const Icon(Icons.create),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    login,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.chevron_right,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (validate()) {

                            }
                          },
                          style: raisedButtonStyle,
                          child: Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  const Icon(Icons.login_rounded),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    createAccount,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.chevron_right,
                                size: 20,
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
                    onPressed: clickLoginGoogle,
                    style: orangeButton,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/google_logo.png",
                            color: Colors.white,
                            height: 30,
                            width: 90,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              loginGoogleText,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  OutlinedButton(
                    onPressed: clickLoginAnonimous,
                    style: greenButtonStyle,
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
                                  fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
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

  void clickLoginGoogle() {
    siginInWithGoogle().then((value) => {
      this.user = value!,
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              user: SimpleUser.n(user),
            ),
          ))
    });

  }

  void clickLoginAnonimous() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: SimpleUser(
                name: AppLocalizations.of(context)!.anonimus,
                email: "${AppLocalizations.of(context)!.passwordField}@${AppLocalizations.of(context)!.passwordField}.com"),
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
