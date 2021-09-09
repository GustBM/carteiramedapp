import 'package:flutter/material.dart';

class UserInfoFormTextField extends StatelessWidget {
  final TextEditingController formController;
  final String labelText;
  final String? initialValue;

  UserInfoFormTextField(this.labelText, this.formController, this.initialValue);

  @override
  Widget build(BuildContext context) {
    if (initialValue != null) formController.text = initialValue!;

    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
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
        if (value!.isEmpty) return 'Preencha o campo com o nome da atividade.';
        return null;
      },
      controller: formController,
      readOnly: initialValue != null,
    );
  }
}
