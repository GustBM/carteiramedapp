import 'package:carteiramedapp/providers/notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:carteiramedapp/screens/home_screen.dart';
import 'package:carteiramedapp/screens/new_user_screen.dart';
import 'package:carteiramedapp/screens/user_info_screen.dart';
import 'package:carteiramedapp/screens/splash_screen.dart';
import 'package:carteiramedapp/providers/auth.dart';
import 'package:carteiramedapp/providers/users_info.dart';
import 'package:carteiramedapp/utils.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(CarteiraMedApp());
}

class CarteiraMedApp extends StatefulWidget {
  @override
  State<CarteiraMedApp> createState() => _CarteiraMedAppState();
}

class _CarteiraMedAppState extends State<CarteiraMedApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();
    configOneSignel();
  }

  void configOneSignel() {
    OneSignal.shared.setAppId('10356065-b84a-4b09-be44-d6cba9137bda');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: UsersInfo(),
        ),
        ChangeNotifierProvider.value(
          value: Notifications(),
        ),
      ],
      child: MaterialApp(
        onGenerateTitle: (context) {
          return AppLocalizations.of(context)!.appTitle;
        },
        theme: ThemeData(
            primarySwatch: createMaterialColor(Colors.blue[200]!),
            accentColor: createMaterialColor(Colors.blueGrey[300]!),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle: TextStyle(color: Theme.of(context).accentColor),
            )),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    textStyle: TextStyle(
              color: Theme.of(context).accentColor,
              decoration: TextDecoration.underline,
            )))),
        supportedLocales: [
          const Locale('pt', 'BR'),
          const Locale('en', ''),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        home: FutureBuilder(
            future: _fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Erro! ${snapshot.error.toString()}');
                return Text("Houve um erro na conex??o com o banco!");
              } else if (snapshot.hasData) {
                return HomeScreen();
              } else {
                return SplashScreen();
              }
            }),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          UserInfoScreen.routeName: (ctx) => UserInfoScreen(),
          NewUserScreen.routeName: (ctx) => NewUserScreen(),
        },
      ),
    );
  }
}
