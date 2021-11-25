import 'dart:ui';

import 'package:carteiramedapp/models/http_exception.dart';
import 'package:carteiramedapp/models/user_info.dart';
import 'package:carteiramedapp/providers/auth.dart';
import 'package:carteiramedapp/providers/users_info.dart';
import 'package:carteiramedapp/screens/new_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    final GlobalKey<FormState> _formKey = GlobalKey();
    var _isLoading = false;

    final _cpfController = TextEditingController();
    final _pwdController = TextEditingController();

    var maskFormatter = new MaskTextInputFormatter(
        mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

    Future<void> _submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      final String cpf = _cpfController.value.text;
      final String pwd = _pwdController.value.text;

      try {
        String? userEmail = await Provider.of<UsersInfo>(context, listen: false)
            .getEmailByCPF(cpf);
        Provider.of<Auth>(context, listen: false)
            .login(context, userEmail!, pwd);
      } on HttpException catch (e) {
        showWarningDialog(context, e.toString());
      } catch (e) {
        showWarningDialog(context, e.toString());
      }
      setState(() {
        _isLoading = false;
      });
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      child: SimpleDialog(
        title: Text(
          t!.entreNaConta,
          textAlign: TextAlign.center,
        ),
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      inputFormatters: [maskFormatter],
                      controller: _cpfController,
                      decoration: InputDecoration(
                        labelText: 'CPF',
                        prefixIcon: Icon(Icons.account_circle_outlined),
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
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return t.invalidoCPF;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _pwdController,
                      decoration: InputDecoration(
                        labelText: t.senha,
                        prefixIcon: Icon(Icons.lock_outline),
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
                        hintStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return t.senhaObrigatoria;
                        }
                        if (value.length < 6) {
                          return t.senhaMaisQue6;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text(t.entrar,
                              style: TextStyle(color: Colors.white70)),
                          onPressed: _submit,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: Text(t.naoCadastrado),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(NewUserScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
