import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:carteiramedapp/screens/home_screen.dart';
import 'package:carteiramedapp/screens/new_user_screen.dart';
import 'package:carteiramedapp/screens/user_info_screen.dart';
import 'package:carteiramedapp/screens/splash_screen.dart';
import 'package:carteiramedapp/providers/auth.dart';
import 'package:carteiramedapp/providers/users_info.dart';
import 'package:carteiramedapp/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CarteiraMedApp());
}

class CarteiraMedApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

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
      ],
      child: MaterialApp(
        title: 'Carteira Médica App',
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
        supportedLocales: [const Locale('pt', 'BR')],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        home: FutureBuilder(
            future: _fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Erro! ${snapshot.error.toString()}');
                return Text("Houve um erro na conexão com o banco!");
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
