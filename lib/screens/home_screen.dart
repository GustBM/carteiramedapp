import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:carteiramedapp/screens/user_info_screen.dart';
import 'package:carteiramedapp/widgets/login_dialog_widget.dart';
import 'package:carteiramedapp/widgets/search_form.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> onSelectNotification(String? payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("teste"),
        content: Text('asdgsag'),
      ),
    );
  }

  @override
  initState() {
    super.initState();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    var initializatonSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializatonSettingsIOS = new IOSInitializationSettings();

    var initializatonSettings = new InitializationSettings(
        android: initializatonSettingsAndroid, iOS: initializatonSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializatonSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'Default_Sound');
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).primaryColor;
    final _user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        // title: Text('widget.title'),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            // Navigator.of(context).pushNamed(UserInfoScreen.routeName);
            _user != null
                ? Navigator.of(context)
                    .pushNamed(UserInfoScreen.routeName, arguments: _user.uid)
                : showDialog<Widget>(
                    context: context,
                    builder: (_) => new LoginDialog(),
                  );
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(224, 224, 224, 1).withOpacity(0.5),
                  Color.fromRGBO(primaryColor.red, primaryColor.green,
                          primaryColor.blue, 1)
                      .withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: deviceWidth < 500 ? deviceWidth : 500,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Bem-vindo a Carteira Médica',
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await _showNotification();
                        },
                        child: Text('asdf')),
                    SizedBox(height: 20),
                    SearchForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
