import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:carteiramedapp/models/user_info.dart';
import 'package:carteiramedapp/providers/auth.dart';
import 'package:carteiramedapp/providers/users_info.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_datefield.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_list.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_textfield.dart';

class UserInfoScreen extends StatelessWidget {
  static const routeName = '/user-info';
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final primaryColor = Theme.of(context).primaryColor;
    String userId = ModalRoute.of(context)!.settings.arguments as String;

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
                child: UserInfoForm(userId),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoForm extends StatefulWidget {
  final String thisUser;
  UserInfoForm(this.thisUser);

  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _bthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isUser =
        Provider.of<Auth>(context, listen: false).currentUserId ==
            widget.thisUser;
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder<QuerySnapshot<UserInf>>(
        future: Provider.of<UsersInfo>(context, listen: false)
            .getUserById(widget.thisUser),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<UserInf>> snapshot) {
          UserInf userInfo;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.size > 0) {
              userInfo = snapshot.data!.docs[0].data();
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                child: CircleAvatar(
                              backgroundImage: Image.asset(
                                      'assets/img/standard_user_img.png')
                                  .image,
                              maxRadius: 75,
                            )),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  UserInfoFormTextField(
                                      'Nome', _nameController, userInfo.name),
                                  SizedBox(height: 10),
                                  UserInfoFormTextField(
                                      'CPF', _cpfController, userInfo.cpf),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        UserInfoFormTextField(
                            'E-mail', _emailController, userInfo.email),
                        SizedBox(height: 10),
                        UserInfoFormDateField('Data de Nascimento',
                            _bthdayController, userInfo.birthDate),
                        SizedBox(height: 10),
                        UserInfoFormList(
                            'Medicações', userInfo.medications, true),
                        UserInfoFormList('Vacinas', userInfo.vaccines, true),
                        UserInfoFormList('Doenças', userInfo.conditions, true),
                        SizedBox(height: 20),
                        isUser
                            ? ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                ),
                                onPressed:
                                    Provider.of<Auth>(context, listen: false)
                                        .logout,
                                child: Text('Sair da Conta'))
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.data!.size == 0) {
              return Center(
                child: Text('Nenhum usuário com o CPF ' + widget.thisUser),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao buscar o usuário'),
              );
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
