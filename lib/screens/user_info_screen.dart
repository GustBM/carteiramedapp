import 'package:carteiramedapp/models/user_info.dart';
import 'package:carteiramedapp/widgets/user_info_form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatelessWidget {
  static const routeName = '/user-info';
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(),
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
                child: UserInfoForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoForm extends StatefulWidget {
  UserInfoForm({Key? key}) : super(key: key);

  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  var thisUser = UserInf(
      cpf: '13047889708',
      name: 'Teste Testerson',
      birthDate: '20/10/1993',
      email: 'teste@teste.com');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: CircleAvatar(
                  backgroundImage:
                      Image.asset('assets/img/standard_user_img.png').image,
                  maxRadius: 75,
                )),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      UserInfoFormTextField(
                          'Nome', _nameController, thisUser.name),
                      SizedBox(height: 10),
                      UserInfoFormTextField(
                          'CPF', _cpfController, thisUser.cpf),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            UserInfoFormTextField('E-mail', _emailController, thisUser.email),
          ],
        ),
      ),
    );
  }
}
