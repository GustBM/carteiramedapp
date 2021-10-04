import 'package:carteiramedapp/screens/user_info_screen.dart';
import 'package:carteiramedapp/widgets/login_dialog_widget.dart';
import 'package:flutter/material.dart';

import 'package:carteiramedapp/widgets/search_form.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).primaryColor;
    // final accentColor = Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(
        // title: Text('widget.title'),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            // Navigator.of(context).pushNamed(UserInfoScreen.routeName);
            showDialog<Widget>(
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
