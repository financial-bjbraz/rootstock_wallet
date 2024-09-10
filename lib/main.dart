import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_rootstock_wallet/pages/message.dart';
import 'package:my_rootstock_wallet/pages/screen.dart';
import 'package:my_rootstock_wallet/pages/splash.dart';
import 'package:my_rootstock_wallet/services/create_user_service.dart';
import 'package:my_rootstock_wallet/services/wallet_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ),
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  AndroidInitializationSettings initializationSettingsAndroid =
  const AndroidInitializationSettings('@mipmap/ic_launcher');

  IOSInitializationSettings iosInitializationSettings =
  IOSInitializationSettings(
    onDidReceiveLocalNotification: (id, title, body, payload) async {
      return await showDialog(
        context: Messaging.openContext,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title ?? ""),
          content: Text(body ?? ""),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screen(
                      text: '',
                    ),
                  ),
                );
              },
            )
          ],
        ),
      );
    },
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: iosInitializationSettings,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        debugPrint('notification payload: $payload');

        await Navigator.push(
          Messaging.openContext,
          MaterialPageRoute<void>(
              builder: (context) => Screen(text: payload.toString())),
        );
      });

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
  await dotenv.load(fileName: ".env");
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
