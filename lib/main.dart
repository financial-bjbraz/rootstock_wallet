import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_rootstock_wallet/pages/splash.dart';
import 'package:my_rootstock_wallet/services/create_user_service.dart';
import 'package:my_rootstock_wallet/services/wallet_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,

    ),
  );
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<WalletServiceImpl> (
        create: (context) => WalletServiceImpl()
      ),
      ChangeNotifierProvider(create: (context) => CreateUserServiceImpl())
    ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    Future<bool> myFuture() async {
      // await Firebase.initializeApp(
      //   options: DefaultFirebaseOptions.currentPlatform,
      // );
      //
      // await FirebaseMessaging.instance.setAutoInitEnabled(true);
      // final fcmToken = await FirebaseMessaging.instance.getToken();
      // if (kDebugMode) {
      //   print("=================================");
      //   print(fcmToken);
      //   print("=================================");
      // }

      return true;
    }

    return FutureBuilder(builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Maniva Wallet',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Splash(),
        );
      }
      return const Center(child: Center(
        child: CircularProgressIndicator(),
      ));
    }, future: myFuture());
  }
}
