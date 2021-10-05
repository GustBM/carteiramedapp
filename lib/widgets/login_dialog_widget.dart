import 'dart:ui';

import 'package:carteiramedapp/models/http_exception.dart';
import 'package:carteiramedapp/screens/new_user_screen.dart';
import 'package:flutter/material.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    var _isLoading = false;

    final _cpfController = TextEditingController();
    final _pwdController = TextEditingController();

    void _submit() {
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
        // Provider.of<UsersInfo>(context, listen: false).getUserByCPF(input);
      } on HttpException catch (e) {
        // showWarningDialog(context, e.toString());
        print(e.toString());
      } catch (e) {
        print(e.toString());
      }
      setState(() {
        _isLoading = false;
      });
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      child: SimpleDialog(
        title: Text(
          'Entre na sua conta',
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
                          return 'CPF inválido!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
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
                    ),
                  ),
                  SizedBox(height: 10),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text('Entrar',
                              style: TextStyle(color: Colors.white70)),
                          onPressed: _submit,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: Text('Não é cadastrado? Regitre-se aqui!'),
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
