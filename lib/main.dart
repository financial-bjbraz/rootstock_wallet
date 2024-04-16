import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_rootstock_wallet/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_rootstock_wallet/services/wallet_service.dart';
import 'package:my_rootstock_wallet/util/util.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,

    ),
  );

  runApp(
    ChangeNotifierProvider<WalletServiceImpl> (
      create: (context) => WalletServiceImpl(),
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    Future<bool> myFuture() async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await FirebaseMessaging.instance.setAutoInitEnabled(true);
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (kDebugMode) {
        print("=================================");
        print(fcmToken);
        print("=================================");
      }

      return true;
    }

    return FutureBuilder(builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Maniva Wallet',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // theme: ThemeData(
          //   scaffoldBackgroundColor: const Color.fromRGBO(41, 49, 69, 20),
          //   brightness: Brightness.dark,
          // ),
          home: Splash(),
          // ignore: missing_return, missing_return
        );
      }
      return const Center(child: Center(
        child: CircularProgressIndicator(),
      ));
    }, future: myFuture());
  }
}
