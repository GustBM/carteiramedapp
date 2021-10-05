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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CarteiraMedApp());
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
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
