import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:carteiramedapp/models/http_exception.dart';
import 'package:carteiramedapp/providers/users_info.dart';

class SearchForm extends StatefulWidget {
  SearchForm({Key? key}) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  final _inputController = TextEditingController();
  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    final String input = _inputController.value.text;
    try {
      Provider.of<UsersInfo>(context, listen: false).getUserByCPF(input);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Busque por CPF ou E-mail',
                  alignLabelWithHint: false),
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              validator: (value) {
                if (value!.isEmpty)
                  return 'Preencha o campo com o CPF ou e-mail.';
                return null;
              },
              controller: _inputController,
            ),
            SizedBox(height: 10),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    child:
                        Text('Buscar', style: TextStyle(color: Colors.white70)),
                    onPressed: _submit,
                  ),
          ],
        ),
      ),
    );
  }
}
