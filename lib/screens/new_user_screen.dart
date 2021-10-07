import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:carteiramedapp/models/http_exception.dart';
import 'package:carteiramedapp/providers/auth.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_datefield.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_list.dart';
import 'package:carteiramedapp/widgets/user_info/user_info_form_textfield.dart';

import '../utils.dart';

class NewUserScreen extends StatefulWidget {
  static const routeName = '/new-user';
  const NewUserScreen({Key? key}) : super(key: key);

  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _registerForm = GlobalKey();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _cpfController = TextEditingController();
    final TextEditingController _bthdayController = TextEditingController();
    final TextEditingController _pwdController = TextEditingController();
    final TextEditingController _confirmPwdController = TextEditingController();
    List<String> _medications = [];
    List<String> _conditions = [];
    List<String> _vaccines = [];

    var _isLoading = false;

    Future<void> _submit() async {
      if (!_registerForm.currentState!.validate()) {
        // Invalid!
        return;
      }
      _registerForm.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false).newUser(
            _cpfController.text,
            _nameController.text,
            _bthdayController.text,
            _emailController.text,
            '',
            _medications,
            _conditions,
            _vaccines,
            _pwdController.text);
      } on HttpException catch (e) {
        showWarningDialog(context, e.toString());
      } catch (e) {
        showWarningDialog(context, e.toString());
      }
      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(224, 224, 224, 1).withOpacity(0.5),
              Color.fromRGBO(
                      Theme.of(context).primaryColor.red,
                      Theme.of(context).primaryColor.green,
                      Theme.of(context).primaryColor.blue,
                      1)
                  .withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _registerForm,
          child: SingleChildScrollView(
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
                              'Nome Completo', _nameController, null),
                          SizedBox(height: 10),
                          UserInfoFormTextField('CPF', _cpfController, null),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                UserInfoFormTextField('E-mail', _emailController, null),
                SizedBox(height: 10),
                UserInfoFormDateField(
                    'Data de Nascimento', _bthdayController, null),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) return 'Este campo é obrigatório.';
                    if (_pwdController.text.length < 6)
                      return 'Senha deve ter no mínimo 6 caracteres.';
                    return null;
                  },
                  controller: _pwdController,
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) return 'Este campo é obrigatório.';
                    if (_pwdController.text != _confirmPwdController.text)
                      return 'A senha e a confirmação não são iguais.';
                    return null;
                  },
                  controller: _confirmPwdController,
                ),
                SizedBox(height: 10),
                UserInfoFormList('Medicações', _medications, false),
                UserInfoFormList('Vacinas', _conditions, false),
                UserInfoFormList('Doenças', _vaccines, false),
                Center(
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submit, child: Text('Cadastrar')),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
