import 'package:carteiramedapp/widgets/user_info_form_datefield.dart';
import 'package:carteiramedapp/widgets/user_info_form_textfield.dart';
import 'package:flutter/material.dart';

class NewUserScreen extends StatelessWidget {
  static const routeName = '/new-user';
  const NewUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _registerForm = GlobalKey();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _cpfController = TextEditingController();
    final TextEditingController _bthdayController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _registerForm,
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
                        UserInfoFormTextField('Nome', _nameController, ''),
                        SizedBox(height: 10),
                        UserInfoFormTextField('CPF', _cpfController, ''),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              UserInfoFormTextField('E-mail', _emailController, ''),
              UserInfoFormDateField(
                  'Data de Nascimento', _bthdayController, ''),
            ],
          ),
        ),
      ),
    );
  }
}
